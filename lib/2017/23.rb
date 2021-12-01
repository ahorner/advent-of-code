INSTRUCTIONS = INPUT.split("\n").map(&:split)

def resolve(registers, value)
  if value.to_i.to_s == value
    value.to_i
  else
    registers[value]
  end
end

registers = Hash.new(0)
runs = Hash.new(0)
cursor = 0

loop do
  break if cursor < 0 || cursor >= INSTRUCTIONS.length

  instruction = INSTRUCTIONS[cursor]
  runs[instruction[0]] += 1

  case instruction[0]
  when "set"
    registers[instruction[1]] = resolve(registers, instruction[2])
  when "sub"
    registers[instruction[1]] -= resolve(registers, instruction[2])
  when "mul"
    registers[instruction[1]] *= resolve(registers, instruction[2])
  when "jnz"
    cursor += resolve(registers, instruction[2]) - 1 if resolve(registers, instruction[1]) != 0
  end

  cursor += 1
end

solve!("The number of `mul` instructions run is:", runs["mul"])

# We're counting non-prime numbers.
require "prime"

values = INSTRUCTIONS.map { |i| i[2].to_i }
starts = (values[0] * values[4]) - values[5]
ends = starts - values[7]
nonprimes = (starts..ends).step(-values[30]).count { |n| !Prime.prime?(n) }

solve!("The value of register h is:", nonprimes)
