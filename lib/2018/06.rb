class Coordinate
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def distance_to(i, j)
    (x - i).abs + (y - j).abs
  end
end

coordinates = INPUT.split("\n").map { |line| Coordinate.new(*line.split(", ").map(&:to_i)) }
westmost, eastmost = coordinates.minmax_by(&:x)
northmost, southmost = coordinates.minmax_by(&:y)

paranoid_grid = {}
friendly_grid = {}

MAX_DISTANCE ||= 10_000

(westmost.x..eastmost.x).each do |x|
  (northmost.y..southmost.y).each do |y|
    distances = coordinates.map { |c| c.distance_to(x, y) }
    friendly_grid[[x, y]] = distances.sum < MAX_DISTANCE

    minimum = distances.min
    next if distances.count(minimum) > 1

    closest = coordinates.detect.with_index { |_, i| distances[i] == minimum }
    paranoid_grid[[x, y]] = closest
  end
end

finite_coordinates = coordinates.reject do |c|
  (westmost.x..eastmost.x).any? { |x| paranoid_grid[[x, southmost.y]] == c || paranoid_grid[[x, northmost.y]] == c } ||
    (northmost.y..southmost.y).any? { |y| paranoid_grid[[westmost.x, y]] == c || paranoid_grid[[eastmost.x, y]] == c }
end

counts = finite_coordinates.map { |c| paranoid_grid.values.count(c) }
solve!("The largest non-infinite area is:", counts.max)

friendly_region = friendly_grid.values.count(true)
solve!("The region of friendly locations has a size of:", friendly_region)
