require "set"

class Coord < Struct.new(:x, :y)
  GROUP_LOCATIONS = [-1, 0, 1].product([-1, 0, 1]).freeze

  def group
    @group ||= GROUP_LOCATIONS.map { |dy, dx| Coord.new(x + dx, y + dy) }
  end

  def hash
    [x, y].hash
  end
end

class Image
  def initialize(grid, algorithm)
    @grid = grid
    @algorithm = algorithm
  end

  def refine
    default = @grid.default ? @algorithm.last : @algorithm.first
    refined = (coords + edges).each_with_object(Hash.new(default)) do |coord, refined|
      refined[coord] = output_for(coord)
    end

    Image.new(refined, @algorithm)
  end

  def count
    @grid.values.count(&:itself)
  end

  private

  def output_for(coord)
    value = coord.group.reduce(0) { |v, n| (v * 2) + (@grid[n] ? 1 : 0) }
    @algorithm[value]
  end

  def coords
    @coords ||= Set.new(@grid.keys)
  end

  def edges
    minx, maxx = coords.map(&:x).minmax
    miny, maxy = coords.map(&:y).minmax

    edges =
      [minx - 1, maxx + 1].product(((miny - 1)..(maxy + 1)).to_a) +
      (minx..maxx).to_a.product([miny - 1, maxy + 1])

    Set.new(edges.map { |x, y| Coord.new(x, y) })
  end
end

algorithm, image = INPUT.split("\n\n")

ALGORITHM = algorithm.chars.map { |c| c == "#" }.freeze
IMAGE = image.split("\n").flat_map.with_index do |line, y|
  line.chars.map.with_index do |c, x|
    [Coord.new(x, y), c == "#"]
  end
end.to_h

image = Image.new(IMAGE, ALGORITHM)
2.times { image = image.refine }
solve!("The number of lit pixels after 2 refinements is:", image.count)

48.times { image = image.refine }
solve!("The number of lit pixels after 50 refinements is:", image.count)
