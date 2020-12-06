require "set"

WIRES = INPUT.split("\n").map { |instructions| instructions.split(",") }.freeze

class Grid
  STEPS = {
    "U" => [0, -1],
    "D" => [0, 1],
    "L" => [-1, 0],
    "R" => [1, 0],
  }.freeze

  def initialize
    @grid = Hash.new { |h, k| h[k] = {} }
  end

  def add(id, steps)
    x = 0
    y = 0
    total = 0

    steps.each do |step|
      distance = step.scan(/\d+/)[0].to_i
      vector = STEPS[step[0]]

      distance.times do
        x += vector[0]
        y += vector[1]
        total += 1

        @grid[[x, y]][id] ||= total
      end
    end
  end

  def intersections
    @grid.keys.select { |position| @grid[position].length > 1 }
  end

  def combined_steps(intersection)
    @grid[intersection].map(&:last).sum
  end
end

grid = Grid.new
WIRES.each_with_index { |steps, id| grid.add(id, steps) }
intersections = grid.intersections

closest = intersections.map { |intersection| intersection.map(&:abs).sum }.min
puts "The manhattan distance to the closest intersection is:", closest, "\n"

min_steps = intersections.map { |intersection| grid.combined_steps(intersection) }.min
puts "The minimum number of combined steps to any intersection is:", min_steps
