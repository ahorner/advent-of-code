require "set"

UNIVERSE = INPUT.split("\n").flat_map.with_index do |line, y|
  line.chars.filter_map.with_index { |c, x| [x, y] if c == "#" }
end

def expand(universe, factor: 2)
  xmax = universe.map(&:first).max
  ymax = universe.map(&:last).max

  expanded_columns = Set.new((0..xmax).reject { |x| universe.any? { |p| p[0] == x } })
  expanded_rows = Set.new((0..ymax).reject { |y| universe.any? { |p| p[1] == y } })

  i = 0
  j = 0

  (0..ymax).each_with_object([]) do |y, planets|
    (0..xmax).each do |x|
      planets << [i, j] if universe.any? { |p| p == [x, y] }
      i += expanded_columns.include?(x) ? factor : 1
    end

    i = 0
    j += expanded_rows.include?(y) ? factor : 1
  end
end

def distance(a, b)
  (a[1] - b[1]).abs + (a[0] - b[0]).abs
end

def pair_total(universe)
  universe.combination(2).sum { |a, b| distance(a, b) }
end

universe = expand(UNIVERSE, factor: 2)
solve!("The sum of lengths between pairs of planets is:", pair_total(universe))

EXPANSION_FACTOR ||= 1000000
universe = expand(UNIVERSE, factor: EXPANSION_FACTOR)
solve!("The sum of lengths between pairs of OLD planets is:", pair_total(universe))
