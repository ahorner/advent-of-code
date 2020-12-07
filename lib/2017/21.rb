def variants(string)
  base = string.split("/").map(&:chars)

  [
    base,
    base.map(&:reverse),
    base.reverse,
    base.reverse.map(&:reverse),
    base.transpose,
    base.transpose.map(&:reverse),
    base.transpose.reverse,
    base.transpose.reverse.map(&:reverse),
  ].uniq.map do |variant|
    variant.map(&:join).join("/")
  end
end

RULES = INPUT.split("\n").each_with_object({}) do |line, rules|
  input, output = line.split(" => ")
  variants(input).each { |variant| rules[variant] = output }
end

def enhance(grid)
  section_size = grid.size.even? ? 2 : 3

  grid.each_slice(section_size).flat_map do |lines|
    portions = lines.map do |line|
      line.chars.each_slice(section_size).map(&:join)
    end.inject(&:zip)

    results = portions.map { |p| RULES[p.join("/")].split("/") }
    results.size > 1 ? results.inject(&:zip).map(&:join) : results.flatten
  end
end

STARTING_GRID = [
  ".#.",
  "..#",
  "###",
].freeze

ITERATIONS ||= 5

grid = STARTING_GRID.dup
ITERATIONS.times { grid = enhance(grid) }
solve!("The number of pixels that stay on after 5 enhancements is:", grid.join.count("#"))

13.times { grid = enhance(grid) }
solve!("The number of pixels that stay on after 18 enhancements is:", grid.join.count("#"))
