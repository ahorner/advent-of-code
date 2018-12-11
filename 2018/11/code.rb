SERIAL = INPUT.to_i
SIZE = 300

def power(x, y)
  rack_id = x + 10

  power = rack_id * y
  power += SERIAL
  power *= rack_id

  ((power / 100) % 10) - 5
end

# Compose a grid containing the _sums_ of all powers from the top-left to the
# specified cell. This allows us to find the value of any arbitrary rectangular
# section using just four points of data. For example, if all cells had a power
# of 1, the sums would look like:
#
#   A |  B    B |  *      1 |  1    1 |  1      1 |  2    3 |  4
# ---------------       ---------------       ---------------
#   C |  D    D |  *      1 |  1    1 |  1      2 |  4    6 |  8
#     |         |    ==     |         |    =>     |         |
#   C |  D    D |  *      1 |  1    1 |  1      3 |  6    9 | 12
# ---------------       ---------------       ---------------
#   *    *    *    *      1    1    1    1      4    8   12   16
#
# You could then calculate the sum of _just_ region D (the central box in the
# diagrams above) by grabbing the bottom-right sums of sections A, B, C, and D
# for a calculation of 9 - 3 - 3 + 1 = 4. This doesn't improve the efficiency of
# calculating small region sums by much, but greatly reduces the calculations
# required to sum large regions.
GRID = (0..SIZE).each_with_object(Array.new(SIZE + 1) { Array.new(SIZE + 1) }) do |x, grid|
  (0..SIZE).each do |y|
    grid[y][x] =
      if x < 1 || y < 1
        0
      else
        power(x, y) + grid[y - 1][x] + grid[y][x - 1] - grid[y - 1][x - 1]
      end
  end
end.freeze

def best_for(grid, size = 3)
  best = [0, 0, 0, size]

  (0..(SIZE - size)).each do |x|
    (0..(SIZE - size)).each do |y|
      total = grid[y + size][x + size] - grid[y + size][x] - grid[y][x + size] + grid[y][x]
      best = [total, x + 1, y + 1, size] if total > best[0]
    end
  end

  best
end

puts "The top-left corner of the best 3x3 block is:", best_for(GRID)[1..2].join(","), nil

best = (3..SIZE).map { |size| best_for(GRID, size) }.max
puts "The best block of any size is:", best[1..3].join(",")
