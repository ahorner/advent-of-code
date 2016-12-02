class Circuit

  def initialize(signals = {})
    @signals = signals
    @wires = {}
  end

  def assemble(instructions)
    instructions.each do |step|
      source, wire = step.split(" -> ")
      @wires[wire] = source.split(" ")
    end
  end

  def reset(signals = {})
    @signals = signals
  end

  def signal(wire)
    return wire.to_i if wire =~ /\A\d+\z/
    @signals[wire] ||= begin
      sources = @wires[wire]

      if sources.include?("AND")
        signal(sources[0]) & signal(sources[2])
      elsif sources.include?("OR")
        signal(sources[0]) | signal(sources[2])
      elsif sources.include?("NOT")
        ~signal(sources[1])
      elsif sources.include?("RSHIFT")
        signal(sources[0]) >> signal(sources[2])
      elsif sources.include?("LSHIFT")
        signal(sources[0]) << signal(sources[2])
      else
        signal(sources[0])
      end
    end
  end
end

circuit = Circuit.new
circuit.assemble(INPUT.split("\n"))

a = circuit.signal("a")

puts "First pass:", a, nil

circuit.reset("b" => a)
a = circuit.signal("a")

puts "Second pass:", a
