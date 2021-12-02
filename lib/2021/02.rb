INSTRUCTION_MATCHER = /(?<instruction>\w+) (?<value>\d+)/.freeze
INSTRUCTIONS = INPUT.split("\n").map do |line|
  match = line.match(INSTRUCTION_MATCHER)
  [match[:instruction].to_sym, match[:value].to_i]
end.freeze

x = 0
y = 0

INSTRUCTIONS.each do |instruction, value|
  case instruction
  when :forward then x += value
  when :down then y += value
  when :up then y -= value
  end
end

solve!("The combined depth/position value is:", x * y)

aim = 0
x = 0
y = 0

INSTRUCTIONS.each do |instruction, value|
  case instruction
  when :forward
    x += value
    y += aim * value
  when :down
    aim += value
  when :up
    aim -= value
  end
end

solve!("The combined aimed depth/position value is:", x * y)
