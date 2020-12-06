SWAP_POSITION_PATTERN = /swap position (?<x>\d) with position (?<y>\d)/.freeze
SWAP_LETTER_PATTERN = /swap letter (?<x>\w) with letter (?<y>\w)/.freeze
ABSOLUTE_ROTATE_PATTERN = /rotate (?<direction>\w+) (?<steps>\d+) step/.freeze
RELATIVE_ROTATE_PATTERN = /rotate based on position of letter (?<char>\w)/.freeze
REVERSE_POSITIONS_PATTERN = /reverse positions (?<x>\d) through (?<y>\d)/.freeze
MOVE_POSITIONS_PATTERN = /move position (?<x>\d) to position (?<y>\d)/.freeze

def act(chars, command)
  chars = chars.dup

  case command
  when SWAP_POSITION_PATTERN
    matches = command.match(SWAP_POSITION_PATTERN)
    x = matches[:x].to_i
    y = matches[:y].to_i
    char = chars[x]
    chars[x] = chars[y]
    chars[y] = char
  when SWAP_LETTER_PATTERN
    matches = command.match(SWAP_LETTER_PATTERN)
    x = chars.index(matches[:x])
    y = chars.index(matches[:y])
    char = chars[x]
    chars[x] = chars[y]
    chars[y] = char
  when ABSOLUTE_ROTATE_PATTERN
    matches = command.match(ABSOLUTE_ROTATE_PATTERN)
    dir = matches[:direction]
    steps = matches[:steps].to_i
    chars.rotate!(dir == "left" ? steps : -steps)
  when RELATIVE_ROTATE_PATTERN
    matches = command.match(RELATIVE_ROTATE_PATTERN)
    char = matches[:char]
    shift = chars.index(char)
    additional = (shift >= 4 ? 1 : 0)
    chars.rotate!(-1 - shift - additional)
  when REVERSE_POSITIONS_PATTERN
    matches = command.match(REVERSE_POSITIONS_PATTERN)
    x = matches[:x].to_i
    y = matches[:y].to_i
    tmp = chars[x..y]
    tmp.reverse.each_with_index do |c, i|
      chars[x + i] = c
    end
  when MOVE_POSITIONS_PATTERN
    matches = command.match(MOVE_POSITIONS_PATTERN)
    x = matches[:x].to_i
    y = matches[:y].to_i
    char = chars.delete_at(x)
    chars.insert(y, char)
  end

  chars
end

def undo(result, command)
  chars = result.dup

  case command
  when SWAP_POSITION_PATTERN, SWAP_LETTER_PATTERN, REVERSE_POSITIONS_PATTERN
    chars = act(chars, command)
  when ABSOLUTE_ROTATE_PATTERN
    matches = command.match(ABSOLUTE_ROTATE_PATTERN)
    dir = matches[:direction]
    steps = matches[:steps].to_i
    chars.rotate!(dir == "left" ? -steps : steps)
  when RELATIVE_ROTATE_PATTERN
    matches = command.match(RELATIVE_ROTATE_PATTERN)
    chars.rotate!(1) while result != act(chars, command)
  when MOVE_POSITIONS_PATTERN
    matches = command.match(MOVE_POSITIONS_PATTERN)
    x = matches[:x].to_i
    y = matches[:y].to_i
    char = chars.delete_at(y)
    chars.insert(x, char)
  end

  chars
end

chars = "abcdefgh".split("")
INPUT.split("\n").each { |line| chars = act(chars, line) }

puts "Your scrambled password is:", chars.join(""), nil

chars = "fbgdceah".split("")
INPUT.split("\n").reverse.each { |line| chars = undo(chars, line) }

puts "Your unscrambled password is:", chars.join("")
