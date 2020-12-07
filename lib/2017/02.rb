ROWS = INPUT.split("\n").map do |row|
  row.split.map(&:to_i)
end

def total(&block)
  ROWS.map(&block).inject(:+)
end

checksum = total { |row| row.max - row.min }
solve!("The checksum by difference is:", checksum)

checksum = total do |row|
  row.detect do |i|
    divisor = row.detect { |j| i != j && i % j == 0 }
    break (i / divisor) if divisor
  end
end
solve!("The checksum by division is:", checksum)
