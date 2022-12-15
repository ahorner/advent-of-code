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
      grid[x + 1, y + 1]
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
    @size = instructions.split("\n").count
    @lights = {}

    instructions.split("\n").each_with_index do |row, x|
      row.chars.each_with_index do |state, y|
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

  def corners
    [
      [0, 0],
      [0, @size - 1],
      [@size - 1, 0],
      [@size - 1, @size - 1]
    ].map do |(x, y)|
      self[x, y]
    end
  end
end

grid = Grid.new(INPUT)
STEPS ||= 100
STEPS.times { grid.tick! }

solve!("Lights on:", grid.count)

grid = Grid.new(INPUT)
grid.corners.each(&:stuck!)

STEPS.times { grid.tick! }

solve!("Lights on (stuck corners):", grid.count)
