require "rb_heap/heap"

CAVE = INPUT.split("\n").map { |line| line.chars.map(&:to_i) }.freeze
DEEP_CAVE =
  (CAVE.size * 5).times.map do |y|
    (CAVE[0].size * 5).times.map do |x|
      depth = (y / CAVE.size) + (x / CAVE[0].size)
      risk = CAVE[y % CAVE.size][x % CAVE[0].size]

      ((risk + depth - 1) % 9) + 1
    end
  end.freeze

class Cave
  DIRECTIONS = [[1, 0], [0, 1], [-1, 0], [0, -1]].freeze

  def initialize(layout)
    @layout = layout
  end

  def height
    @height ||= @layout.size
  end

  def width
    @width ||= @layout[0].size
  end

  def cost((x, y))
    @layout[y][x]
  end

  def adjacent_spots((x, y))
    DIRECTIONS.filter_map do |dx, dy|
      next if x + dx < 0 || x + dx >= width
      next if y + dy < 0 || y + dy >= height

      [x + dx, y + dy]
    end
  end
end

class Spelunker
  def initialize(cave)
    @cave = cave
  end

  def risk(start, target)
    queue = Heap.new { |a, b| a[0] < b[0] }
    queue << [0, start]

    costs = { start => 0 }

    loop do
      break if queue.empty?

      cost, spot = queue.pop
      break cost if spot == target

      @cave.adjacent_spots(spot).each do |new_spot|
        new_cost = cost + @cave.cost(new_spot)
        next if costs.key?(new_spot) && costs[new_spot] <= new_cost

        costs[new_spot] = new_cost
        queue << [new_cost, new_spot]
      end
    end
  end
end

cave = Cave.new(CAVE)
spelunker = Spelunker.new(cave)
risk = spelunker.risk([0, 0], [cave.width - 1, cave.height - 1])
solve!("The minimal risk to traverse the cave is:", risk)

cave = Cave.new(DEEP_CAVE)
spelunker = Spelunker.new(cave)
risk = spelunker.risk([0, 0], [cave.width - 1, cave.height - 1])
solve!("The minimal risk to traverse the deep cave is:", risk)
