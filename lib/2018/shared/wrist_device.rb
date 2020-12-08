class WristDevice
  def initialize(pointer = 0, registers = [])
    @registers = registers
    @pointer = pointer
  end

  def run(instructions)
    registers = @registers.dup

    loop do
      yield registers if block_given?

      pointer = registers[@pointer]
      break if pointer < 0 || pointer >= instructions.count

      registers = execute(registers, *instructions[pointer])
      registers[@pointer] += 1
    end

    registers
  end

  def execute(registers, opcode, a, b, c)
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
end
