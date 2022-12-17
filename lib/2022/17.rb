require "matrix"

class Rock
  attr_reader :height, :width

  def initialize(diagram)
    diagram = diagram.split("\n").map(&:chars)

    @height = diagram.size
    @width = diagram[0].size
    @shape = diagram.flat_map.with_index do |r, y|
      r.filter_map.with_index { |c, x| Vector[x, -y] if c == "#" }
    end
  end

  def coords_at(position)
    @shape.map { |s| s + position }
  end
end

class Tower
  TRACK_LAYERS = 7
  WIDTH = 7

  attr_reader :height

  def initialize
    @chamber = WIDTH.times.to_h { |i| [Vector[i, 0], true] }
    @height = 0
  end

  def add!(rock, position)
    @height = [position[1], @height].max
    rock.coords_at(position).each { |v| @chamber[v] = true }
  end

  def grow!(growth)
    @height += growth
    @chamber = @chamber.transform_keys { |v| v + Vector[0, growth] }
  end

  def valid?(rock, position)
    return false if position[0] < 0 || position[0] + rock.width > WIDTH

    rock.coords_at(position).none? { |v| @chamber[v] }
  end

  def hash
    WIDTH.times.flat_map do |x|
      ((@height - TRACK_LAYERS)..@height).map { |y| @chamber[Vector[x, y]] }
    end.hash
  end
end

DIAGRAMS = <<~ROCKS
  ####

  .#.
  ###
  .#.

  ..#
  ..#
  ###

  #
  #
  #
  #

  ##
  ##
ROCKS

ROCKS = DIAGRAMS.split("\n\n").map { |diagram| Rock.new(diagram) }
JETS = INPUT.chars
DOWN = Vector[0, -1]
RIGHT = Vector[1, 0]
LEFT = Vector[-1, 0]

def height_after(count)
  tower = Tower.new
  states = {}
  jets = 0
  rocks = 0

  loop do
    break tower.height if rocks == count

    rock = ROCKS[rocks % ROCKS.size]
    position = Vector[2, tower.height + rock.height + 3]

    loop do
      push = (JETS[jets % JETS.size] == "<") ? LEFT : RIGHT
      jets += 1

      position += push if tower.valid?(rock, position + push)

      if tower.valid?(rock, position + DOWN)
        position += DOWN
      else
        tower.add!(rock, position)
        break
      end
    end

    state = [rocks % ROCKS.size, jets % JETS.size, tower]

    if states.key?(state)
      previous_rocks, previous_height = states[state]
      cycles = (count - rocks) / (rocks - previous_rocks)
      rocks += (rocks - previous_rocks) * cycles

      tower.grow!((tower.height - previous_height) * cycles)
    else
      states[state] = [rocks, tower.height]
    end

    rocks += 1
  end
end

solve!(
  "The height after 2022 rocks is:",
  height_after(2022)
)

solve!(
  "The height after 1000000000000 rocks is:",
  height_after(1000000000000)
)
