STEPS = INPUT.to_i
LAST_VALUE = 2017

buffer = [0]
cursor = 0

LAST_VALUE.times do |i|
  cursor += STEPS
  cursor %= buffer.length
  buffer.insert(cursor + 1, i + 1)
  cursor += 1
end

solve!("The value after 2017 is:", buffer[buffer.index(LAST_VALUE) + 1])

value = 0
cursor = 0
50_000_000.times do |i|
  cursor += STEPS
  cursor %= i + 1
  value = i + 1 if cursor == 0
  cursor += 1
end

solve!("The value after 0 (after 50 million inserts) is:", value)
