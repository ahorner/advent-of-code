require "matrix"

MAP = INPUT.split("\n").each_with_index.each_with_object({}) do |(row, y), grid|
  row.chars.each_with_index do |tile, x|
    grid[Vector[x, y]] = tile
  end
end

XMAX = MAP.keys.map { |position| position[0] }.max
YMAX = MAP.keys.map { |position| position[1] }.max

ANTENNAS = (MAP.values.uniq - ["."]).each_with_object({}) do |frequency, antennas|
  antennas[frequency] = MAP.keys.select { |position| MAP[position] == frequency }
end

def out_of_bounds?(node)
  node[0] < 0 || node[1] < 0 || node[0] > XMAX || node[1] > YMAX
end

def single_antinodes(a, b)
  d = b - a
  [a - d, b + d].reject { |node| out_of_bounds?(node) }
end

def multi_antinodes(a, b)
  antinodes = [a, b]
  d = b - a

  a -= d
  b += d

  loop do
    break antinodes if out_of_bounds?(a) && out_of_bounds?(b)

    antinodes += [a, b].reject { |node| out_of_bounds?(node) }

    a -= d
    b += d
  end
end

def antinodes_for(map, multi = false)
  ANTENNAS.each_with_object({}) do |(_, antennas), antinode_map|
    antennas.combination(2).each do |a, b|
      antinodes = multi ? multi_antinodes(a, b) : single_antinodes(a, b)
      antinodes.each do |antinode|
        antinode_map[antinode] = true
      end
    end
  end
end

solve!("The number of unique antinode positions is:", antinodes_for(MAP).count)
solve!("The number of antinode positions with the updated model is:", antinodes_for(MAP, true).count)
