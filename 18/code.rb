class Light

  attr_reader :x, :y, :grid

  def initialize(grid, x, y, on)
    @grid = grid
    @x = x
    @y = y
    @on = on
    @set = nil
  end

  def neighbors
    @neighbors ||= [
      grid[x - 1, y - 1],
      grid[x - 1, y],
      grid[x - 1, y + 1],
      grid[x, y - 1],
      grid[x, y + 1],
      grid[x + 1, y - 1],
      grid[x + 1, y],
      grid[x + 1, y + 1],
    ].uniq.compact
  end

  def on?
    return true if @stuck
    !!@on
  end

  def check!
    @set =
      if on?
        [2, 3].include?(neighbors.count(&:on?))
      else
        neighbors.count(&:on?) == 3
      end
  end

  def tick!
    @on = @set
    @set = nil
  end

  def stuck!
    @stuck = true
  end

end

class Grid

  def initialize(instructions)
    @lights = {}

    instructions.split("\n").each_with_index do |row, x|
      row.split("").each_with_index do |state, y|
        @lights[[x, y]] = Light.new(self, x, y, state == "#")
      end
    end
  end

  def [](x, y)
    @lights[[x, y]]
  end

  def tick!
    @lights.values.each(&:check!).each(&:tick!)
  end

  def count
    @lights.values.count(&:on?)
  end

end

grid = Grid.new(INPUT)
100.times { grid.tick! }

puts "Lights on:", grid.count, nil

grid = Grid.new(INPUT)
grid[0, 0].stuck!
grid[0, 99].stuck!
grid[99, 0].stuck!
grid[99, 99].stuck!

100.times { grid.tick! }

puts "Lights on (stuck corners):", grid.count, nil
