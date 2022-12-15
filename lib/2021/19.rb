require "set"

SCANS = INPUT.split("\n\n").map do |scan|
  _name, *coords = scan.split("\n")
  coords.map { |coord| coord.split(",").map(&:to_i) }
end.freeze

class Scanner
  ROTATIONS = [0, 1, 2].permutation.to_a.freeze
  INVERSIONS = [1, -1].repeated_permutation(3).to_a.freeze

  def initialize(scan)
    @scan = scan
  end

  def test
    ROTATIONS.each do |(x, y, z)|
      INVERSIONS.each do |(dx, dy, dz)|
        yield @scan.map { |beacon| [beacon[x] * dx, beacon[y] * dy, beacon[z] * dz] }
      end
    end
  end
end

def align(a, b)
  Scanner.new(b).test do |orientation|
    a.each do |(ax, ay, az)|
      orientation.each do |(bx, by, bz)|
        origin = [bx - ax, by - ay, bz - az]
        beacons = orientation.map { |(x, y, z)| [x - origin[0], y - origin[1], z - origin[2]] }

        return [true, origin, beacons] if beacons.count { |b| a.include?(b) } >= 12
      end
    end
  end

  [false, nil, nil]
end

positions = {0 => [0, 0, 0]}
beacons = {0 => Set.new(SCANS[0])}
tried = Set.new

loop do
  break if positions.count == SCANS.count

  SCANS.each_index do |i|
    next if positions[i]

    positions.keys.each do |j| # rubocop:disable Style/HashEachMethods
      tried.include?([i, j]) ? next : tried << [i, j]

      success, position, scan = align(beacons[j], SCANS[i])

      next unless success

      positions[i] = position
      beacons[i] = Set.new(scan)

      break
    end
  end
end

solve!("The total beacon count is:", beacons.values.inject(:+).count)

distances = positions.values.combination(2).map do |a, b|
  a.zip(b).sum { |i, j| (i - j).abs }
end

solve!("The maximum distance between beacons is:", distances.max)
