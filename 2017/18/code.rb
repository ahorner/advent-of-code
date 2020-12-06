class Program
  INSTRUCTIONS = INPUT.split("\n").map do |line|
    action, *args = line.split
    [action.to_sym, args.map { |i| i =~ /-?\d+/ ? i.to_i : i }]
  end.freeze

  attr_accessor :outputs, :sent

  def initialize(id = 0)
    @registers = Hash.new(0)
    @registers["p"] = id

    @outputs = []
    @waiting = nil
    @sent = 0
    @cursor = 0
  end

  def run
    loop do
      break if @waiting
      break if @cursor < 0 || @cursor >= INSTRUCTIONS.length

      action, args = INSTRUCTIONS[@cursor]

      case action
      when :snd
        @sent += 1
        @outputs << value_for(args[0])
      when :set
        @registers[args[0]] = value_for(args[1])
      when :add
        @registers[args[0]] += value_for(args[1])
      when :mul
        @registers[args[0]] *= value_for(args[1])
      when :mod
        @registers[args[0]] %= value_for(args[1])
      when :rcv
        @waiting = args[0]
      when :jgz
        @cursor += (value_for(args[1]) - 1) if value_for(args[0]) > 0
      end

      @cursor += 1
    end
  end

  def resume(value)
    @registers[@waiting] = value
    @waiting = nil

    run
  end

  private

  def value_for(n)
    n.is_a?(String) ? @registers[n] : n
  end
end

program = Program.new
program.run

puts "The last value output by the program was:", program.outputs.last, nil

program0 = Program.new(0)
program1 = Program.new(1)

program0.run
program1.run

loop do
  break if program0.outputs.empty? && program1.outputs.empty?

  program0.resume(program1.outputs.shift) if program1.outputs.any?
  program1.resume(program0.outputs.shift) if program0.outputs.any?
end

puts "The number of outputs sent by Program 1 was:", program1.sent
