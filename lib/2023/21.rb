require "matrix"
require "set"

class Map
  MOVEMENTS = [Vector[0, -1], Vector[1, 0], Vector[0, 1], Vector[-1, 0]]

  attr_reader :size, :grid

  def initialize
    @grid = {}
    @size = 0
  end

  def start
    @start ||= @grid.key("S")
  end

  def [](coord)
    @grid[coord]
  end

  def []=(coord, value)
    @size = [size, coord[0] + 1].max
    @grid[coord] = value
  end

  def neighbors(coord)
    MOVEMENTS.filter_map do |movement|
      plot = coord + movement
      plot if self[plot] == "." || self[plot] == "S"
    end
  end

  def corners
    [Vector[0, 0], Vector[0, size - 1], Vector[size - 1, 0], Vector[size - 1, size - 1]]
  end

  def edges
    [Vector[start[0], size - 1], Vector[0, start[1]], Vector[start[0], 0], Vector[size - 1, start[1]]]
  end
end

MAP = INPUT.split("\n").each_with_index.each_with_object(Map.new) do |(line, y), map|
  line.chars.each_with_index { |c, x| map[Vector[x, y]] = c }
end

def step_map(start, map)
  queue = [[start, 0]]
  counts = {}

  loop do
    break counts if queue.empty?
    position, steps = queue.shift

    next if counts.key?(position)
    counts[position] = steps

    map.neighbors(position).each do |plot|
      queue << [plot, steps + 1]
    end
  end
end

def reachable_plots(steps, step)
  steps.values.count { |s| s <= step && step % 2 == s % 2 }
end

counts = step_map(MAP.start, MAP)

STEPS ||= 64
solve!("The number of reachable plots is:", reachable_plots(counts, STEPS))

# A general solution here doesn't seem likely. This approach uses a bunch of
# assumptions about the input, including: (1) the number of steps we're checking
# divides evenly into our map's size, and (2) there are clear paths from the
# starting point to the edges. Under these assumptions, the input for the puzzle
# creates a diamond pattern that looks like the below, with a few different
# plot "tiles" to analyze:
#
#                               SA TT SA
#                            SA LA EE LA SA
#                         SA LA EE OO EE LA SA
#                      SA LA EE OO EE OO EE LA SA
#                      TT EE OO EE OO EE OO EE TT
#                      SA LA EE OO EE OO EE LA SA
#                         SA LA EE OO EE LA SA
#                            SA LA EE LA SA
#                               SA TT SA
#
# OO - An "odd" tile, where the elf has passed through all plots and lands
#      on an even step number.
# EE - An "even" tile, where the elf has passed through all plots and lands
#      on an even step number.
# LA - A "large angled" tile, where the elf passes through _most_ of the plots
#      starting at one corner.
# SA - A "small angled" tile, where the elf passes through _some_ of the plots
#      starting at one corner.
# TT - A "tip" tile, where the elf navigates from the center of one side to
#      all plots reachable within the remaining steps.
#
# We compute the number of plots by determining how many tiles of each type
# will show up in the final grid, and multiplying by the number of plots
# reached in those tiles.
def reachable_infinite_plots(map, steps)
  tiles = (steps - map.start[0]) / map.size

  starting_tile = step_map(map.start, map)
  odds = starting_tile.values.count(&:odd?) * ((tiles - 1)**2)
  evens = starting_tile.values.count(&:even?) * (tiles**2)

  large_angle_steps = map.size + map.size / 2 - 1
  small_angle_steps = map.size / 2 - 1
  tip_steps = map.size - 1

  angled_tiles = map.corners.map { |angle| step_map(angle, map) }
  tip_tiles = map.edges.map { |tip| step_map(tip, map) }

  large_angled_plots = angled_tiles.sum { |tile| reachable_plots(tile, large_angle_steps) } * (tiles - 1)
  small_angled_plots = angled_tiles.sum { |tile| reachable_plots(tile, small_angle_steps) } * tiles
  tip_plots = tip_tiles.sum { |tile| reachable_plots(tile, tip_steps) }

  odds + evens + large_angled_plots + small_angled_plots + tip_plots
end

INFINITE_STEPS ||= 26501365
solve!("The number of reachable plots on an infinite grid is:", reachable_infinite_plots(MAP, INFINITE_STEPS))
