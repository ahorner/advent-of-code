require "set"

INSTRUCTION_MATCHER = /^(?<opcode>\w+) (?<value>\+?-?\d+)$/.freeze
INSTRUCTIONS = INPUT.split("\n").map { |line| line.match(INSTRUCTION_MATCHER) }

def run(instructions)
  pointer = 0
  accumulator = 0
  previous = Set.new

  loop do
    previous << pointer

    instruction = instructions[pointer]
    case instruction[:opcode]
    when "acc" then accumulator += instruction[:value].to_i
    when "jmp" then pointer += instruction[:value].to_i - 1
    end

    pointer += 1

    break [true, accumulator] if pointer >= instructions.count
    break [false, accumulator] if previous.include?(pointer)
  end
end

_success, value = run(INSTRUCTIONS)
solve!("The value of the accumulator before looping is:", value)

TEST_CODES = %w[nop jmp].freeze
final = INSTRUCTIONS.each_with_index do |instruction, index|
  next unless TEST_CODES.include?(instruction[:opcode])

  new_instruction = [{
    opcode: (instruction[:opcode] == "nop" ? "jmp" : "nop"),
    value: instruction[:value],
  }]

  success, value = run(INSTRUCTIONS[0...index] + new_instruction + INSTRUCTIONS[index + 1..])
  break value if success
end

solve!("The value of the accumulator after fixing is:", final)
