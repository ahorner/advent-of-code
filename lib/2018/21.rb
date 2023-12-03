require_relative "shared/wrist_device"
require "set"

ip, instructions = INPUT.split("\n").partition.with_index { |_, i| i == 0 }

POINTER = ip.first.match(/\#ip (?<ip>\d+)/)[:ip].to_i
INSTRUCTIONS = instructions.map do |line|
  line = line.split
  [line.shift.to_sym, *line.map(&:to_i)]
end

# The instructions only perform a check against register 0 at one specific
# point, comparing it to the contents of a different register.
COMPARISON_LINE = INSTRUCTIONS.index { |i| i[0] == :eqrr && i[2] == 0 }
COMPARISON_POINTER = INSTRUCTIONS[COMPARISON_LINE][1]

device = WristDevice.new(POINTER, [0, 0, 0, 0, 0, 0])
value = device.run(INSTRUCTIONS) do |registers|
  break registers[COMPARISON_POINTER] if registers[POINTER] == COMPARISON_LINE
end

solve!("The earliest halting value for register 0 is:", value)

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

value = device.run(INSTRUCTIONS) do |registers|
  case registers[POINTER]
  when COMPARISON_LINE
    break last if seen.include?(registers[COMPARISON_POINTER])

    last = registers[COMPARISON_POINTER]
    seen << last
  when RESET_LINE
    registers[RESET_POINTER] = registers[MASK_POINTER] / 256
  when LOOP_LINE
    registers[LOOP_POINTER] = 1
  end
end

solve!("The last unique halting value for register 0 is:", value)
