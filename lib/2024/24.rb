setup, outputs = INPUT.split("\n\n")

WIRE_MATCHER = /\A(?<wire>.+): (?<value>0|1)\z/
WIRES = setup.split("\n").each_with_object({}) do |line, wires|
  match = line.match(WIRE_MATCHER)
  wires[match[:wire]] = match[:value].to_i(2)
end

GATE_MATCHER = /\A(?<w1>.+) (?<gate>.+) (?<w2>.+) -> (?<output>.+)\z/
GATES = outputs.split("\n").each_with_object({}) do |line, gates|
  match = line.match(GATE_MATCHER)
  gates[match[:output]] = [match[:w1], match[:w2], match[:gate]]
end

def value_for(wire, wires, gates)
  wires[wire] ||= begin
    w1, w2, gate = gates[wire]

    v1 = value_for(w1, wires, gates)
    v2 = value_for(w2, wires, gates)

    case gate
    when "XOR" then v1 ^ v2
    when "AND" then v1 & v2
    when "OR" then v1 | v2
    end
  end
end

def value_on(wires, prefix)
  keys = wires.keys.select { |w| w.start_with?(prefix) }
  keys.sort.reverse.map { |k| wires[k] }.join.to_i(2)
end

def value(wires, gates)
  wires = wires.dup

  gates.keys.each do |output|
    value_for(output, wires, gates)
  end

  value_on(wires, "z")
end

solve!("The final value on the Z wires is:", value(WIRES, GATES))

def used_for?(wire, gates, &block)
  gates.any? { |_, (w1, w2, g)| (w1 == wire || w2 == wire) && block.call(g) }
end

HIGHEST_OUTPUT_BIT = GATES.keys.select { |k| k.start_with?("z") }.max

invalid_outputs = GATES.each_with_object([]) do |(output, (w1, w2, gate)), invalid|
  invalid_operations = [
    output.start_with?("z") && gate != "XOR" && output != HIGHEST_OUTPUT_BIT,
    gate == "AND" && w1 != "x00" && w2 != "x00" && used_for?(output, GATES) { |op| op != "OR" },
    gate == "XOR" && [output, w1, w2].none? { |w| w.start_with?("x", "y", "z") },
    gate == "XOR" && used_for?(output, GATES) { |op| op == "OR" }
  ]

  invalid << output if invalid_operations.any?
end

solve!("The swapped outputs are:", invalid_outputs.sort.join(","))
