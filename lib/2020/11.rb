FLOORPLAN = INPUT.split("\n").each_with_object({}).with_index do |(line, grid), y|
  line.split("").each_with_index { |seat, x| grid[[x, y]] = seat }
end

ADJACENCIES = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].freeze
EMPTY = "L".freeze
OCCUPIED = "#".freeze
FLOOR = ".".freeze

def stabilize(grid, tolerance, neighbors)
  loop do
    result = grid.each_with_object({}) do |((x, y), seat), updated|
      updated[[x, y]] =
        case seat
        when EMPTY then neighbors.call(grid, x, y) == 0 ? OCCUPIED : EMPTY
        when OCCUPIED then neighbors.call(grid, x, y) >= tolerance ? EMPTY : OCCUPIED
        else seat
        end
    end

    break grid if result == grid

    grid = result
  end
end

def total_occupied(grid)
  grid.values.count { |seat| seat == OCCUPIED }
end

neighbors = lambda do |grid, x, y|
  ADJACENCIES.count { |dx, dy| grid[[x + dx, y + dy]] == OCCUPIED }
end

solve!("The stable occupied seat count is:", total_occupied(stabilize(FLOORPLAN, 4, neighbors)))

neighbors = lambda do |grid, x, y|
  ADJACENCIES.count do |(dx, dy)|
    vector = [x + dx, y + dy]
    vector = [vector[0] + dx, vector[1] + dy] until grid[vector] != FLOOR
    grid[vector] == OCCUPIED
  end
end

solve!("The stable occupied seat count with new rules is:", total_occupied(stabilize(FLOORPLAN, 5, neighbors)))
