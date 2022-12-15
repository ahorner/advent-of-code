require "matrix"

POSITION_MATCHER = /x=(?<x>-?\d+), y=(?<y>-?\d+)/.freeze
ROW ||= 2_000_000
SEARCH_SPACE ||= 4_000_000
FREQUENCY_KEY = 4_000_000

pairs = INPUT.split("\n").map do |line|
  line.scan(POSITION_MATCHER).map { |x, y| Vector[x.to_i, y.to_i] }
end

SENSORS = pairs.map { |sensor, beacon| [sensor, (sensor - beacon).sum(&:abs)] }
BEACONS = pairs.map(&:last).uniq

def merge_ranges(ranges)
  result = []
  current = nil

  ranges.sort_by(&:begin).each do |range|
    next current = range if current.nil?
    next if range.end <= current.end

    if current.end >= range.begin
      current = current.begin..range.end
    else
      result << current
      current = range
    end
  end

  result << current if current
  result
end

def coverage_for(row, min: -Float::INFINITY, max: Float::INFINITY)
  ranges = SENSORS.filter_map do |sensor, range|
    d = range - (sensor[1] - row).abs
    next if d <= 0

    x = sensor[0]
    next if (x + d) < min
    next if (x - d) > max

    begins = [x - d, min].max
    ends = [x + d, max].min
    begins..ends
  end

  merge_ranges(ranges)
end

def impossible_spaces(row)
  blocked = coverage_for(row)
  beacons = BEACONS.filter_map { |b| b[0] if b[1] == row }.uniq

  ignored = beacons.count { |x| blocked.any? { |r| r.include?(x) } }

  blocked.sum(&:size) - ignored
end

solve!(
  "The number of beacon-less positions is:",
  impossible_spaces(ROW),
)

x, y =
  SEARCH_SPACE.times do |row|
    ranges = coverage_for(row, min: 0, max: SEARCH_SPACE)
    break [ranges.first.end + 1, row] if ranges.size > 1
  end

solve!(
  "The tuning frequency of the distress beacon is:",
  (x * FREQUENCY_KEY) + y,
)
