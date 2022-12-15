require "matrix"

class Cave
  SOURCE = Vector[500, 0]
  TESTS = [Vector[0, 1], Vector[-1, 1], Vector[1, 1]].freeze

  attr_reader :grains

  def initialize(structures)
    @map = structures.dup

    @bottom = @map.keys.map { |p| p[1] }.max
    @floor = @bottom + 2
    @grains = 0
  end

  def drop!(void: true)
    grain = SOURCE

    loop do
      return if void && grain[1] >= @bottom
      break if !void && grain[1] + 1 >= @floor

      direction = TESTS.find { |test| !@map.key?(grain + test) }
      break if direction.nil?

      grain += direction
    end

    @grains += 1
    @map[grain] = @grains

    grain
  end
end

MAP = INPUT.split("\n").each_with_object({}) do |line, map|
  coords = line.scan(/(\d+),(\d+)/).map { |x, y| Vector[x.to_i, y.to_i] }
  coords.each_cons(2) do |origin, destination|
    d = destination - origin
    move = Vector[d[0] <=> 0, d[1] <=> 0]
    (d.r.to_i + 1).times.map { |i| map[origin + (move * i)] = true }
  end
end

cave = Cave.new(MAP)
loop do
  grain = cave.drop!
  break if grain.nil?
end

solve!(
  "The count of resting grains of sand above the void is:",
  cave.grains
)

loop do
  grain = cave.drop!(void: false)
  break if grain == Cave::SOURCE
end

solve!(
  "The count of resting grains of sand with a floor is:",
  cave.grains
)
