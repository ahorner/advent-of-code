require_relative "shared/wrist_device"

OPCODES = %i[addr addi mulr muli banr bani borr bori setr seti gtir gtri gtrr eqir eqri eqrr].freeze

SAMPLE_MATCHER = /Before: \[(?<input>.+)\]\n(?<command>.+)\nAfter:  \[(?<output>.+)\]/
SAMPLES = INPUT.scan(SAMPLE_MATCHER).map do |input, command, output|
  {
    command: command.split.map(&:to_i),
    input: input.split(", ").map(&:to_i),
    output: output.split.map(&:to_i)
  }
end.freeze

device = WristDevice.new
behaviors = SAMPLES.each_with_object(Hash.new { |h, k| h[k] = [] }) do |sample, codes|
  OPCODES.each do |opcode|
    output = device.execute(sample[:input], opcode, *sample[:command].last(3))
    codes[sample] << opcode if output == sample[:output]
  end
end

solve!("The number of samples that behave like 3+ opcodes is:", behaviors.count { |_k, v| v.size >= 3 })

INSTRUCTION_MATCHER = /\n\n\n\n([0-9 \n]+)/
INSTRUCTIONS = INPUT.match(INSTRUCTION_MATCHER)[1].split("\n").map { |i| i.split.map(&:to_i) }.freeze
OPCODE_MAPPINGS = begin
  mappings = {}

  loop do
    break mappings if OPCODES.all? { |code| mappings.key(code) }

    behaviors.each { |sample, codes| mappings[sample[:command].first] ||= codes.first if codes.size == 1 }
    behaviors.delete_if { |sample, _| mappings.key?(sample[:command].first) }
    behaviors.each { |_, codes| mappings.each_value { |code| codes.delete(code) } }
  end
end.freeze

device = WristDevice.new
registers = [0, 0, 0, 0]

INSTRUCTIONS.each do |instruction|
  registers = device.execute(registers, OPCODE_MAPPINGS[instruction[0]], *instruction[1..])
end

solve!("The result of register 0 after running all instructions is:", registers[0])
