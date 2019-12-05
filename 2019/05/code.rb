INTCODE = INPUT.split(",").map(&:to_i).freeze

class Memory
  def initialize(state)
    @state = state.dup
  end

  def instruction(pointer)
    parameter = @state[pointer]

    opcode = parameter % 100
    modes = (2..4).map { |i| (parameter / (10 ** i)) % 10 }

    [opcode, modes.zip([pointer + 1, pointer + 2, pointer + 3])]
  end

  def []((mode, register))
    case mode
    when 0 then @state[@state[register]]
    when 1 then @state[register]
    end
  end

  def []=((mode, register), value)
    case mode
    when 0 then @state[@state[register]] = value
    when 1 then raise "Invalid storage mode!"
    end
  end
end

class Computer
  def initialize(intcode)
    @program = intcode
  end

  def run(inputs: [])
    memory = Memory.new(@program)
    pointer = 0
    outputs = []

    loop do
      opcode, arguments = memory.instruction(pointer)
      pointer =
        case opcode
        when 1
          memory[arguments[2]] = memory[arguments[0]] + memory[arguments[1]]
          pointer + 4
        when 2
          memory[arguments[2]] = memory[arguments[0]] * memory[arguments[1]]
          pointer + 4
        when 3
          memory[arguments[0]] = inputs.shift
          pointer + 2
        when 4
          outputs << memory[arguments[0]]
          pointer + 2
        when 5
          memory[arguments[0]] != 0 ? memory[arguments[1]] : pointer + 3
        when 6
          memory[arguments[0]] == 0 ? memory[arguments[1]] : pointer + 3
        when 7
          memory[arguments[2]] = memory[arguments[0]] < memory[arguments[1]] ? 1 : 0
          pointer + 4
        when 8
          memory[arguments[2]] = memory[arguments[0]] == memory[arguments[1]] ? 1 : 0
          pointer + 4
        when 99
          break
        end
    end

    outputs
  end
end

computer = Computer.new(INTCODE)
outputs = computer.run(inputs: [1])
puts "The diagnostic code for the air conditioner unit is:", outputs.last, "\n"

outputs = computer.run(inputs: [5])
puts "The diagnostic code for the thermal radiator controller is:", outputs.last
