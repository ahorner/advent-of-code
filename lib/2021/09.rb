MAP = INPUT.split("\n").map { |line| line.chars.map(&:to_i) }.freeze
BASIN_THRESHOLD = 9
NEIGHBORS = [
  [-1, 0],
  [1, 0],
  [0, -1],
  [0, 1]
].freeze

def neighbors_for(x, y)
  NEIGHBORS.filter_map do |dx, dy|
    nx = x + dx
    ny = y + dy

    next if ny < 0 || ny >= MAP.size
    next if nx < 0 || nx >= MAP[0].size

    [nx, ny]
  end
end

low_points = MAP.flat_map.with_index do |row, y|
  row.filter_map.with_index do |n, x|
    [x, y] if neighbors_for(x, y).all? { |i, j| MAP[j][i] > n }
  end
end

solve!("The sum of low point scores is:", low_points.sum { |(x, y)| MAP[y][x] + 1 })

def basin_neighbors(x, y)
  neighbors = neighbors_for(x, y).select do |i, j|
    MAP[j][i] > MAP[y][x] && MAP[j][i] != BASIN_THRESHOLD
  end

  [[x, y]] + neighbors.flat_map { |(i, j)| basin_neighbors(i, j) }.uniq
end

basin_sizes = low_points.map { |(x, y)| basin_neighbors(x, y).count }.sort

solve!("The product of the three largest basin sizes is:", basin_sizes.last(3).inject(:*))
