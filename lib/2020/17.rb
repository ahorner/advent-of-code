INITIAL = INPUT.split("\n").each_with_object({}).with_index do |(row, grid), y|
  row.chars.each_with_index { |cube, x| grid[[x, y]] = cube }
end

ACTIVE = "#".freeze
INACTIVE = ".".freeze

def cycle(grid, dimensions: 3)
  adjacencies = ([-1, 0, 1].repeated_permutation(dimensions).to_a - [[0] * dimensions]).freeze

  grid = grid.each_with_object({}) do |(coord, cube), final|
    extended_coord = coord + ([0] * (dimensions - coord.length))
    final[extended_coord] = cube
  end

  ranges = dimensions.times.map do |i|
    starts, ends = grid.keys.map { |coords| coords[i] }.minmax
    (starts - 1..ends + 1).to_a
  end

  result = Hash.new(INACTIVE)

  ranges[0].product(*ranges[1..]).each do |coord|
    count = adjacencies.count do |deltas|
      neighbor = coord.map.with_index { |c, i| c + deltas[i] }
      grid[neighbor] == ACTIVE
    end

    result[coord] =
      case grid[coord]
      when ACTIVE then [2, 3].include?(count) ? ACTIVE : INACTIVE
      else count == 3 ? ACTIVE : INACTIVE
      end
  end

  result
end

CYCLES = 6

grid = INITIAL.dup
CYCLES.times { grid = cycle(grid) }

solve!("The number of active 3-d cubes is:", grid.values.count { |cube| cube == ACTIVE })

grid = INITIAL.dup
CYCLES.times { grid = cycle(grid, dimensions: 4) }

solve!("The number of active 4-d cubes is:", grid.values.count { |cube| cube == ACTIVE })
