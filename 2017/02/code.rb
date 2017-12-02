ROWS = INPUT.split("\n").map do |row|
  row.split(" ").map(&:to_i)
end

def total
  ROWS.map { |row| yield row }.inject(:+)
end

checksum = total { |row| row.max - row.min }
puts "The checksum by difference is:", checksum, nil

checksum = total do |row|
  row.detect do |i|
    divisor = row.detect { |j| i != j && i % j == 0 }
    break (i / divisor) if divisor
  end
end
puts "The checksum by division is:", checksum
