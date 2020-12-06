OPCODES = %i[addr addi mulr muli banr bani borr bori setr seti gtir gtri gtrr eqir eqri eqrr].freeze

SAMPLE_MATCHER = /Before: \[(?<input>.+)\]\n(?<command>.+)\nAfter:  \[(?<output>.+)\]/.freeze
SAMPLES = INPUT.scan(SAMPLE_MATCHER).map do |input, command, output|
  {
    command: command.split.map(&:to_i),
    input: input.split(", ").map(&:to_i),
    output: output.split.map(&:to_i),
  }
end.freeze

INSTRUCTION_MATCHER = /\n\n\n\n([0-9 \n]+)/.freeze
INSTRUCTIONS = INPUT.match(INSTRUCTION_MATCHER)[1].split("\n").map { |i| i.split.map(&:to_i) }.freeze

def result(registers, opcode, a, b, c)
  registers = registers.dup

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

  registers
end

behaviors = SAMPLES.each_with_object(Hash.new { |h, k| h[k] = [] }) do |sample, codes|
  OPCODES.each do |opcode|
    output = result(sample[:input], opcode, *sample[:command].last(3))
    codes[sample] << opcode if output == sample[:output]
  end
end

solve!("The number of samples that behave like 3+ opcodes is:", behaviors.count { |_k, v| v.size >= 3 })

opcode_mappings = {}

loop do
  break if OPCODES.all? { |code| opcode_mappings.key(code) }

  behaviors.each { |sample, codes| opcode_mappings[sample[:command].first] ||= codes.first if codes.size == 1 }
  behaviors.delete_if { |sample, _| opcode_mappings.key?(sample[:command].first) }
  behaviors.each { |_, codes| opcode_mappings.each_value { |code| codes.delete(code) } }
end

OPCODE_MAPPINGS = opcode_mappings.freeze

registers = [0, 0, 0, 0]
INSTRUCTIONS.each do |instruction|
  registers = result(registers, OPCODE_MAPPINGS[instruction[0]], *instruction[1..])
end

solve!("The result of register 0 after running all instructions is:", registers[0])
