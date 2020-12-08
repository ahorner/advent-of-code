ROWS = INPUT.split("\n").map do |row|
  row.split.map(&:to_i)
end

checksum = ROWS.sum { |row| row.max - row.min }
solve!("The checksum by difference is:", checksum)

checksum = ROWS.sum do |row|
  row.detect do |i|
    divisor = row.detect { |j| i != j && i % j == 0 }
    break (i / divisor) if divisor
  end
end
solve!("The checksum by division is:", checksum)
