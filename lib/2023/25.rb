require "set"

WIRES = INPUT.split("\n").each_with_object(Hash.new { |h, k| h[k] = Set.new }) do |line, wires|
  component, connections = line.split(": ")
  components = connections.split(" ")

  wires[component] += components
  components.each { |c| wires[c] << component }
end

def split(wires)
  remaining = wires.keys.to_set

  loop do
    external = 0
    extract = remaining.max_by { |node| (wires[node].to_set - remaining).size.tap { |c| external += c } }

    break [remaining, wires.keys.to_set - remaining] if external == 3
    remaining.delete(extract)
  end
end

a, b = split(WIRES)
solve!("The product of group sizes is:", a.size * b.size)
