class Circuit
  BOUNDARY = 65_536

  def initialize(signals = {})
    @signals = signals
    @wires = {}
  end

  def assemble!(instructions)
    instructions.each do |step|
      source, wire = step.split(" -> ")
      @wires[wire] = source.split
    end
  end

  def reset!(signals = {})
    @signals = signals
  end

  def signal(wire)
    return wire.to_i if /\A\d+\z/.match?(wire)

    @signals[wire] ||= begin
      sources = @wires[wire]
      result =
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

      result % BOUNDARY
    end
  end
end

circuit = Circuit.new
circuit.assemble!(INPUT.split("\n"))

WIRE ||= "a".freeze
a = circuit.signal(WIRE)
solve!("First pass:", a)

circuit.reset!("b" => a)
solve!("Second pass:", circuit.signal(WIRE))
