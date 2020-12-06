STEPS = INPUT.to_i

buffer = [0]
cursor = 0
2017.times do |i|
  cursor += STEPS
  cursor %= buffer.length
  buffer.insert(cursor + 1, i + 1)
  cursor += 1
end

puts "The value after 2017 is:", buffer[buffer.index(0) + 1], nil

value = 0
cursor = 0
50_000_000.times do |i|
  cursor += STEPS
  cursor %= i + 1
  value = i + 1 if cursor == 0
  cursor += 1
end

puts "The value after 0 (after 50 million inserts) is:", value
