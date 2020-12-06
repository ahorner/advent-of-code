class Nanobot
  attr_reader :x, :y, :z, :range

  def initialize(x, y, z, range)
    @x = x
    @y = y
    @z = z
    @range = range
  end

  def position
    [x, y, z]
  end

  def reaches?(position)
    (x - position[0]).abs + (y - position[1]).abs + (z - position[2]).abs <= range
  end
end

MATCHER = /pos=<(?<x>-?\d+),(?<y>-?\d+),(?<z>-?\d+)>, r=(?<range>\d+)/.freeze
NANOBOTS = INPUT.split("\n").map do |line|
  data = line.match(MATCHER)
  Nanobot.new(
    data[:x].to_i,
    data[:y].to_i,
    data[:z].to_i,
    data[:range].to_i,
  )
end

signal = NANOBOTS.max_by(&:range)
solve!("The strongest signal reaches N nanobots:", NANOBOTS.count { |n| signal.reaches?(n.position) })

def distance_to(x, y, z)
  x.abs + y.abs + z.abs
end

# We can figure out the general area by downsampling, picking an optimal block,
# then zooming in on that block and refining the search area further.
RESOLUTION = 2
downsample = RESOLUTION
downsample *= RESOLUTION until downsample > signal.range

ranges = [
  NANOBOTS.map { |n| n.x / downsample }.minmax,
  NANOBOTS.map { |n| n.y / downsample }.minmax,
  NANOBOTS.map { |n| n.z / downsample }.minmax,
]

distance = loop do
  downsampled = NANOBOTS.map { |n| [n.x / downsample, n.y / downsample, n.z / downsample, n.range / downsample] }

  position = [0, 0, 0]
  best = 0

  (ranges[0][0]..ranges[0][1]).each do |x|
    (ranges[1][0]..ranges[1][1]).each do |y|
      (ranges[2][0]..ranges[2][1]).each do |z|
        count = downsampled.count { |d| distance_to(d[0] - x, d[1] - y, d[2] - z) <= d[3] }

        next if count < best
        next if count == best && distance_to(x, y, z) > distance_to(*position)

        position = [x, y, z]
        best = count
      end
    end
  end

  break distance_to(*position) if downsample == 1

  downsample /= RESOLUTION
  ranges = position.map { |i| [(i - 1) * RESOLUTION, (i + 1) * RESOLUTION] }
end

solve!("The distance from 0,0 to the optimal teleport location is:", distance)
