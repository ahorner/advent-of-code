def transform(original)
  modified = original.reverse.gsub(/(0|1)/, "0" => "1", "1" => "0")
  "#{original}0#{modified}"
end

def checksum(string)
  hash = ""
  string.chars.each_slice(2) do |(x, y)|
    hash << (x == y ? "1" : "0")
  end

  hash.length.even? ? checksum(hash) : hash
end

def checksum_for(length)
  output = transform(INPUT)
  output = transform(output) while output.length < length

  checksum(output[0...length])
end

DISK_LENGTH ||= 272
solve!("The checksum for length 272 is:", checksum_for(DISK_LENGTH))
solve!("The checksum for length 35651584 is:", checksum_for(35_651_584))
