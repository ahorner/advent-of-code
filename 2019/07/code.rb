INTCODE = INPUT.split(",").map(&:to_i).freeze

class Memory
  attr_reader :state

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
    @memory = Memory.new(intcode)
    @pointer = 0
    @running = true
  end

  def run(inputs: [])
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
        return outputs.last if inputs.none?

        @memory[arguments[0]] = inputs.shift
        @pointer += 2
      when 4
        outputs << @memory[arguments[0]]
        @pointer += 2
      when 5
        @pointer = @memory[arguments[0]] != 0 ? @memory[arguments[1]] : @pointer + 3
      when 6
        @pointer = @memory[arguments[0]] == 0 ? @memory[arguments[1]] : @pointer + 3
      when 7
        @memory[arguments[2]] = @memory[arguments[0]] < @memory[arguments[1]] ? 1 : 0
        @pointer += 4
      when 8
        @memory[arguments[2]] = @memory[arguments[0]] == @memory[arguments[1]] ? 1 : 0
        @pointer += 4
      when 99
        @running = false
        break
      end
    end

    outputs.last
  end

  def running?
    @running
  end
end

def amplify(phase_settings)
  signal = 0
  amplifiers = phase_settings.map do |setting|
    Computer.new(INTCODE).tap { |cpu| cpu.run(inputs: [setting]) }
  end

  loop do
    amplifiers.each { |amplifier| signal = amplifier.run(inputs: [signal]) }
    break if amplifiers.none?(&:running?)
  end

  signal
end

def optimal_signal(phases)
  phases.permutation.to_a.map { |phase_settings| amplify(phase_settings) }.max
end

puts "The maximum thruster signal is:", optimal_signal([0, 1, 2, 3, 4]), "\n"
puts "The maximum feedback loop thruster signal is:", optimal_signal([5, 6, 7, 8, 9])
