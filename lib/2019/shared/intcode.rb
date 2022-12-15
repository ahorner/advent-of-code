INTCODE = INPUT.split(",").map(&:to_i).freeze

class Memory
  attr_accessor :base

  def initialize(state)
    @state = Hash.new { |h, k| h[k] = state[k] || 0 }
    @base = 0
  end

  def instruction(pointer)
    parameter = @state[pointer]

    opcode = parameter % 100
    modes = (2..4).map { |i| (parameter / (10**i)) % 10 }

    [opcode, modes.zip([pointer + 1, pointer + 2, pointer + 3])]
  end

  def []((mode, register))
    case mode
    when 0 then @state[@state[register]]
    when 1 then @state[register]
    when 2 then @state[@base + @state[register]]
    end
  end

  def []=((mode, register), value)
    case mode
    when 0 then @state[@state[register]] = value
    when 2 then @state[@base + @state[register]] = value
    else raise "Invalid storage mode!"
    end
  end
end

class Computer
  def initialize(intcode)
    @memory = Memory.new(intcode)
    @pointer = 0
  end

  def [](register)
    @memory[[1, register]]
  end

  def run(inputs: [])
    @running = true
    outputs = []

    loop do
      opcode, arguments = @memory.instruction(@pointer)

      case opcode
      when 1
        @memory[arguments[2]] = @memory[arguments[0]] + @memory[arguments[1]]
        @pointer += 4
      when 2
        @memory[arguments[2]] = @memory[arguments[0]] * @memory[arguments[1]]
        @pointer += 4
      when 3
        return outputs if inputs.none?

        @memory[arguments[0]] = inputs.shift
        @pointer += 2
      when 4
        outputs << @memory[arguments[0]]
        @pointer += 2
      when 5
        @pointer = (@memory[arguments[0]] == 0) ? @pointer + 3 : @memory[arguments[1]]
      when 6
        @pointer = (@memory[arguments[0]] == 0) ? @memory[arguments[1]] : @pointer + 3
      when 7
        @memory[arguments[2]] = (@memory[arguments[0]] < @memory[arguments[1]]) ? 1 : 0
        @pointer += 4
      when 8
        @memory[arguments[2]] = (@memory[arguments[0]] == @memory[arguments[1]]) ? 1 : 0
        @pointer += 4
      when 9
        @memory.base += @memory[arguments[0]]
        @pointer += 2
      when 99
        @running = false
        break
      end
    end

    outputs
  end

  def running?
    @running
  end
end
