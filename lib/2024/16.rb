require "rb_heap/heap"
require "matrix"

class Maze
  DIRECTIONS = %i[e s w n]
  MOVES = {e: Vector[1, 0], s: Vector[0, 1], w: Vector[-1, 0], n: Vector[0, -1]}
  WALL = "#"

  STEP_COST = 1
  TURN_COST = 1000

  def initialize(maze)
    @maze = maze
  end

  def options(start, facing)
    [
      ([start + MOVES[facing], facing, STEP_COST] unless @maze[start + MOVES[facing]] == WALL),
      [start, DIRECTIONS[(DIRECTIONS.index(facing) - 1) % DIRECTIONS.length], TURN_COST],
      [start, DIRECTIONS[(DIRECTIONS.index(facing) + 1) % DIRECTIONS.length], TURN_COST]
    ].compact
  end

  def optimal_routes(start, goal)
    facing = :e
    queue = Heap.new { |a, b| a[0] < b[0] }
    queue << [0, start, facing, []]

    scores = {[start, facing] => 0}
    origins = {[start, facing] => []}

    loop do
      break if queue.empty?

      score, spot, facing = queue.pop
      options(spot, facing).each do |new_spot, new_facing, cost|
        key = [new_spot, new_facing]
        new_score = score + cost

        next if scores.key?(key) && scores[key] < new_score

        if scores.key?(key) && scores[key] == new_score
          origins[key] << [spot, facing]
        else
          scores[key] = new_score
          origins[key] = [[spot, facing]]

          queue << [new_score, new_spot, new_facing] unless new_spot == goal
        end
      end
    end

    {
      scores: scores.select { |(position, facing), score| position == goal },
      origins: origins
    }
  end

  def best_score(start, goal)
    optimal_routes(start, goal)[:scores].min_by(&:last)[1]
  end

  def best_tiles(start, goal)
    routes = optimal_routes(start, goal)
    route = routes[:scores].min_by(&:last)[0]
    origins = routes[:origins][route]

    tiles = Set.new([route[0]] + origins.map(&:first))

    loop do
      break tiles.count if origins.empty?

      origins = origins.flat_map do |origin|
        routes[:origins][origin].each do |tile, _|
          tiles << tile
        end
      end
    end
  end
end

MAZE = INPUT.split("\n").each_with_index.each_with_object({}) do |(line, y), grid|
  line.chars.each_with_index do |c, x|
    grid[Vector[x, y]] = c
  end
end

START = MAZE.key("S")
GOAL = MAZE.key("E")

maze = Maze.new(MAZE)
solve!("The minimum possible score is:", maze.best_score(START, GOAL))
solve!("The number of tiles along optimal paths is:", maze.best_tiles(START, GOAL))
