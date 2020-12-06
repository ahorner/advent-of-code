PATTERN = INPUT.split("\n").map { |line| line.split("") }
SLOPES = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2],
].freeze

class Map
  TREE = "#".freeze

  def initialize(pattern)
    @pattern = pattern
    @width = pattern.first.size
  end

  def [](x, y)
    @pattern[y]&.[](x % @width)
  end

  def collisions(dx, dy)
    x = 0
    y = 0
    count = 0

    loop do
      x += dx
      y += dy

      case self[x, y]
      when TREE then count += 1
      when nil then break
      end
    end

    count
  end
end

map = Map.new(PATTERN)

solve!("The number of trees hit is:", map.collisions(3, 1))
solve!("The product of trees hit on all test slopes is:",
  SLOPES.map { |(dx, dy)| map.collisions(dx, dy) }.inject(:*))
