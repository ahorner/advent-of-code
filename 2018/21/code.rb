require "set"

ip, instructions = INPUT.split("\n").partition.with_index { |_, i| i == 0 }

POINTER = ip.first.match(/\#ip (?<ip>\d+)/)[:ip].to_i
INSTRUCTIONS = instructions.map do |line|
  line = line.split(" ")
  [line.shift.to_sym, *line.map(&:to_i)]
end

def process!(registers, opcode, a, b, c)
  registers[c] =
    case opcode
    when :addr then registers[a] + registers[b]
    when :addi then registers[a] + b
    when :mulr then registers[a] * registers[b]
    when :muli then registers[a] * b
    when :banr then registers[a] & registers[b]
    when :bani then registers[a] & b
    when :borr then registers[a] | registers[b]
    when :bori then registers[a] | b
    when :setr then registers[a]
    when :seti then a
    when :gtir then a > registers[b] ? 1 : 0
    when :gtri then registers[a] > b ? 1 : 0
    when :gtrr then registers[a] > registers[b] ? 1 : 0
    when :eqir then a == registers[b] ? 1 : 0
    when :eqri then registers[a] == b ? 1 : 0
    when :eqrr then registers[a] == registers[b] ? 1 : 0
    end
end

def run(registers)
  loop do
    yield registers
    pointer = registers[POINTER]
    process!(registers, *INSTRUCTIONS[pointer])
    registers[POINTER] += 1
  end
end

# The instructions only perform a check against register 0 at one specific
# point, comparing it to the contents of a different register.
COMPARISON_LINE = INSTRUCTIONS.index { |i| i[0] == :eqrr && i[2] == 0 }
COMPARISON_POINTER = INSTRUCTIONS[COMPARISON_LINE][1]

value = run([0, 0, 0, 0, 0, 0]) do |registers|
  break registers[COMPARISON_POINTER] if registers[POINTER] == COMPARISON_LINE
end

puts "The earliest halting value for register 0 is:", value, nil

# We can avoid a bunch of extraneous looping by overriding a few separate sets
# of instructions to condense each inner loop pass down to one or two
# operations (from several hundred).
MASK_LINE = INSTRUCTIONS.index { |i| i[0] == :bani && i[2] == 255 }
MASK_POINTER = INSTRUCTIONS[MASK_LINE][1]
RESET_LINE = INSTRUCTIONS.index { |i| i[0] == :setr && i[3] == MASK_POINTER }
RESET_POINTER = INSTRUCTIONS[MASK_LINE][3]

LOOP_POINTER = INSTRUCTIONS.detect { |i| i[0] == :muli && i[2] == 256 }[3]
LOOP_LINE = INSTRUCTIONS.index { |i| i[0] == :addr && i[1] == LOOP_POINTER && i[3] == POINTER }

seen = Set.new
last = nil

value = run([0, 0, 0, 0, 0, 0]) do |registers|
  if registers[POINTER] == COMPARISON_LINE
    break last if seen.include?(registers[COMPARISON_POINTER])

    last = registers[COMPARISON_POINTER]
    seen << last
  elsif registers[POINTER] == RESET_LINE
    registers[RESET_POINTER] = registers[MASK_POINTER] / 256
  elsif registers[POINTER] == LOOP_LINE
    registers[LOOP_POINTER] = 1
  end
end

puts "The last unique halting value for register 0 is:", value
