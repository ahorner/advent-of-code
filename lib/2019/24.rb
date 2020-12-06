SIZE = 5
ADJACENCIES = [[0, -1, 0], [1, 0, 0], [0, 1, 0], [-1, 0, 0]].freeze
GRID = INPUT.split("\n").each_with_index.each_with_object(Hash.new(".")) do |(line, y), grid|
  line.split("").each_with_index { |tile, x| grid[[x, y, 0]] = tile }
end

def tick(grid, neighbors)
  positions = grid.flat_map { |position, tile| tile == "#" ? [position] + neighbors.call(position) : [] }.uniq
  positions.each_with_object(Hash.new(".")) do |position, updated|
    bugs = neighbors.call(position).count { |neighbor| grid[neighbor] == "#" }
    updated[position] =
      case grid[position]
      when "#" then bugs == 1 ? "#" : "."
      when "." then [1, 2].include?(bugs) ? "#" : "."
      end
  end
end

def biodiversity(grid)
  (0...SIZE).sum do |y|
    (0...SIZE).sum do |x|
      grid[[x, y, 0]] == "#" ? 2**(y * SIZE + x) : 0
    end
  end
end

def neighbors(coord)
  x, y, z = coord
  ADJACENCIES.map { |i, j, k| [x + i, y + j, z + k] }
end

grid = GRID.dup
seen = {}
neighbors = proc do |(x, y, z)|
  ADJACENCIES.map do |i, j, k|
    next if x + i < 0 || y + j < 0 || x + i >= SIZE || y + j >= SIZE

    [x + i, y + j, z + k]
  end.compact
end

repeated = loop do
  grid = tick(grid, neighbors)
  value = biodiversity(grid)

  break value if seen[value]

  seen[value] = true
end

solve!("The biodiversity of the first layout that appears twice is:", repeated)

RECURSIVE_ADJACENCIES = {
  [0, -1, 0] => ->(x) { [x, SIZE - 1] },
  [1, 0, 0] => ->(y) { [0, y] },
  [0, 1, 0] => ->(x) { [x, 0] },
  [-1, 0, 0] => ->(y) { [SIZE - 1, y] },
}.freeze

recursive_neighbors = proc do |(x, y, z)|
  ADJACENCIES.flat_map do |i, j, k|
    if x + i == SIZE / 2 && y + j == SIZE / 2
      SIZE.times.map(&RECURSIVE_ADJACENCIES[[i, j, k]]).map { |m, n| [m, n, z + 1] }
    elsif x + i < 0 || y + j < 0 || x + i >= SIZE || y + j >= SIZE
      [[SIZE / 2 + i, SIZE / 2 + j, z - 1]]
    else
      [[x + i, y + j, z + k]]
    end
  end
end

grid = GRID.dup

MINUTES ||= 200
MINUTES.times { grid = tick(grid, recursive_neighbors) }

solve!("The number of bugs after 200 minutes is:", grid.values.count("#"))
