instructions, nodes = INPUT.split("\n\n")

NODE_MATCHER = /\A(?<id>.+) = \((?<left>.+), (?<right>.+)\)\z/
INSTRUCTIONS = instructions.chars
NETWORK = nodes.split("\n").to_h do |node|
  data = node.match(NODE_MATCHER)

  [data[:id], [data[:left], data[:right]]]
end

steps = 0
node = "AAA"

steps = loop do
  step = (INSTRUCTIONS[steps % INSTRUCTIONS.count] == "L") ? 0 : 1
  node = NETWORK[node][step]
  steps += 1

  break steps if node == "ZZZ"
end

solve!("The number of steps required to escape is:", steps)

steps = 0
nodes = NETWORK.keys.select { |node| node.end_with?("A") }
checkpoints = Array.new(nodes.length)
periods = Array.new(nodes.length)

steps = loop do
  step = (INSTRUCTIONS[steps % INSTRUCTIONS.count] == "L") ? 0 : 1
  nodes = nodes.map { |node| NETWORK[node][step] }
  steps += 1

  nodes.each_with_index do |n, i|
    next unless periods[i].nil? && n.end_with?("Z")

    if checkpoints[i] && periods[i].nil?
      periods[i] = steps - checkpoints[i]
    elsif checkpoints[i].nil?
      checkpoints[i] = steps
    end
  end

  break periods.reduce(&:lcm) if periods.all?
end

solve!("The number of steps required for a ghost to escape is:", steps)
