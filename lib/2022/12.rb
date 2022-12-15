require "matrix"
require "rb_heap/heap"

class Hill
  DIRECTIONS = [Vector[1, 0], Vector[0, 1], Vector[-1, 0], Vector[0, -1]].freeze

  def initialize(map)
    @map = map
  end

  def origins_for(destination)
    DIRECTIONS.filter_map do |move|
      origin = destination + move
      next unless @map.key?(origin)
      next unless height(destination) - height(origin) <= 1

      origin
    end
  end

  def height(spot)
    letter = @map[spot]

    case letter
    when "S" then "a".ord
    when "E" then "z".ord
    else letter.ord
    end
  end
end

class Climber
  def initialize(hill)
    @hill = hill
  end

  def steps_to(goal)
    queue = Heap.new { |a, b| a[0] < b[0] }
    queue << [0, goal]

    costs = {goal => 0}

    loop do
      break costs if queue.empty?

      cost, spot = queue.pop
      @hill.origins_for(spot).each do |new_spot|
        new_cost = cost + 1
        next if costs.key?(new_spot) && costs[new_spot] <= new_cost

        costs[new_spot] = new_cost
        queue << [new_cost, new_spot]
      end
    end
  end
end

MAP = INPUT.split("\n").each_with_object({}).with_index do |(line, map), y|
  line.chars.each_with_index do |c, x|
    map[Vector[x, y]] = c
  end
end.freeze

START = MAP.key("S")
GOAL = MAP.key("E")

hill = Hill.new(MAP)
climber = Climber.new(hill)
steps = climber.steps_to(GOAL)

solve!(
  "The minimum step count from S to E is:",
  steps[START]
)

trailheads = MAP.filter_map { |spot, elevation| steps[spot] if elevation == "a" }
solve!(
  "The minimum step count from an optimal trailhead is:",
  trailheads.min
)
