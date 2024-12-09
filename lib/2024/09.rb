FILESYSTEM = INPUT.chars.each_slice(2).each_with_index.each_with_object([]) do |((file, space), index), system|
  file.to_i.times { system << index }
  space.to_i.times { system << nil }
end

def compact_blocks(filesystem)
  compacted = filesystem.dup

  cursor = 0
  tail = compacted.length - 1

  loop do
    if compacted[cursor]
      cursor += 1 until compacted[cursor].nil?
    end
    if compacted[tail].nil?
      tail -= 1 until compacted[tail]
    end

    break compacted if tail <= cursor

    compacted[cursor] = compacted[tail]
    compacted[tail] = nil

    cursor += 1
    tail -= 1
  end
end

def checksum(filesystem)
  filesystem.each_with_index.sum { |file, pos| file ? file * pos : 0 }
end

solve!("The checksum after block-level compacting is:", checksum(compact_blocks(FILESYSTEM)))

def compact_files(filesystem)
  compacted = filesystem.dup

  file = compacted.last
  loop do
    break compacted if file <= 0

    file_starts = compacted.index(file)
    filesize = 0
    filesize += 1 until compacted[file_starts + filesize] != file

    cursor = compacted.index(nil)

    loop do
      break if cursor >= file_starts

      available = 0
      available += 1 while compacted[cursor + available].nil?

      if available >= filesize
        filesize.times do |i|
          compacted[cursor + i] = file
          compacted[file_starts + i] = nil
        end

        break
      end

      cursor = cursor + available + 1
      cursor += 1 until compacted[cursor].nil?
    end

    file -= 1
  end
end

solve!("The checksum after whole-file compacting is:", checksum(compact_files(FILESYSTEM)))
