VENT_MATCHER = /(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)/.freeze
VENTS = INPUT.split("\n").map { |line| line.match(VENT_MATCHER) }

def range_for(begins, ends)
  min = [begins, ends].min
  min == begins ? (begins..ends).to_a : begins.downto(ends).to_a
end

def map_for(vents, diagonals: false)
  vents.each_with_object(Hash.new { |h, k| h[k] = 0 }) do |vent, map|
    next unless diagonals || (vent[:x1] == vent[:x2]) || (vent[:y1] == vent[:y2])

    y_range = range_for(vent[:y1].to_i, vent[:y2].to_i)
    x_range = range_for(vent[:x1].to_i, vent[:x2].to_i)

    x_range *= y_range.length if x_range.length == 1
    y_range *= x_range.length if y_range.length == 1

    x_range.zip(y_range).each do |x, y|
      map[[x, y]] += 1
    end
  end
end

def overlapping_vents(map)
  map.values.count { |vent| vent > 1 }
end

map = map_for(VENTS)
solve!("The number of overlapping vents is:", overlapping_vents(map))

map = map_for(VENTS, diagonals: true)
solve!("The number of overlapping vents (with diagonals) is:", overlapping_vents(map))
