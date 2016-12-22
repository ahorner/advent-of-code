NODE_PATTERN = /\/dev\/grid\/node-x(?<x>\d+)-y(?<y>\d+)\s+(?<size>\d+)T\s+(?<used>\d+)T\s+(?<avail>\d+)T\s+(?<percent>\d+)\%/

class DevNode

  attr_accessor :size, :used, :avail

  def initialize(size, used, avail)
    @size = size
    @used = used
    @avail = avail
  end

  def possible_move?(other_node)
    other_node.size > @used
  end

  def fits?(other_node)
    other_node.used <= @avail
  end

  def take(other_node)
    @used += other_node.used
    @avail -= other_node.used
    other_node.avail += other_node.used
    other_node.used = 0
  end

  def empty?
    @used == 0
  end

end

class NodePair

  def initialize(a, b)
    @a = a
    @b = b
  end

  def valid?
    return false if @a.empty?
    return false if @b == @a
    @b.fits?(@a)
  end

end

def adjacent_nodes(nodes, x, y)
  [
    [x + 1, y],
    [x - 1, y],
    [x, y + 1],
    [x, y - 1],
  ].select { |(i, j)| nodes.key?([i, j]) }
end

nodes = INPUT.split("\n")[2..-1].each_with_object({}) do |line, list|
  matches = line.match(NODE_PATTERN)
  list[[matches[:x].to_i, matches[:y].to_i]] = DevNode.new(
    matches[:size].to_i,
    matches[:used].to_i,
    matches[:avail].to_i,
  )
end

viable_pairs = nodes.values.product(nodes.values).count do |(a, b)|
  !a.empty? && b != a && b.fits?(a)
end

puts "The number of viable pairs is:", viable_pairs, nil

# Screw solving this problem the "correct" way. I'm so done with pathfinding
# challenges this season. The challenge is _clearly_ easier to solve by hand
# with some idiotic heuristics, so I'm not going to bother coding anything other
# than basic math.
#
# (.) .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . [.]
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  -  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
#
# Thanks for creating the first truly unenjoyable challenge, topaz.

high_nodes = nodes.select { |_, node| node.size > 400 }
wall = high_nodes.min_by { |(x, y)| x }

empty_node = nodes.detect { |_, node| node.empty? }
x, y = empty_node.first

steps_to_target = (37 - x).abs + (0 - y).abs
additional_steps = 2 * (wall.first[0] - x - 1).abs
steps_to_goal = 36 * 5
total_steps = steps_to_target + additional_steps + steps_to_goal

puts "The minimum step count is:", total_steps

