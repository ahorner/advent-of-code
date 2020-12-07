class Maze
  def initialize(nodes)
    @nodes = nodes
  end

  def wall?(node)
    @nodes[node]
  end

  def adjacent_spots((x, y))
    [
      [x + 1, y],
      [x - 1, y],
      [x, y + 1],
      [x, y - 1],
    ].compact.reject { |spot| wall?(spot) }
  end
end

# Apologies to http://branch14.org/snippets/a_star_in_ruby.html
class PriorityQueue
  def initialize
    @list = []
  end

  def add(priority, item)
    @list << [priority, @list.length, item]
    @list.sort!
  end

  def next
    @list.shift[2]
  end

  def empty?
    @list.empty?
  end
end

class Pathfinder
  def initialize(maze)
    @maze = maze
  end

  def path(start, target)
    estimator = proc { |(x, y)| (target[0] - x).abs + (target[1] - y).abs }
    traverse(start, estimator: estimator) { |spot, path| return path if spot == target }
  end

  private

  def traverse(start, estimator: proc { 0 })
    found = {}
    queue = PriorityQueue.new
    queue.add(1, [start, [], 0])

    loop do
      spot, path, steps = queue.next
      next if found[spot]

      yield spot, path

      found[spot] = true
      @maze.adjacent_spots(spot).each do |new_spot|
        next if found[new_spot]

        new_steps = steps + 1

        queue.add(
          new_steps + estimator.call(new_spot),
          [new_spot, [*path, new_spot], new_steps],
        )
      end
      break if queue.empty?
    end
  end
end

class PathCache
  def initialize(maze)
    @cache = {}
    @maze = maze
  end

  def fetch(from, to)
    @cache[[from, to]] ||= Pathfinder.new(@maze).path(from, to)
  end
end

def minimum_path(maze, start, goals, return_home: false)
  cache = PathCache.new(maze)

  goals.permutation.map do |goal_order|
    current = start
    path = goal_order.flat_map do |goal|
      segment = cache.fetch(current, goal)
      current = goal

      segment
    end

    path += cache.fetch(current, start) if return_home

    path
  end.min_by(&:length)
end

nodes = {}
start = nil
goals = []

INPUT.split("\n").each_with_index do |line, row|
  line.split("").each_with_index do |char, column|
    node = [row, column]

    case char
    when "0"
      start = node
    when /\d/
      goals << node
    end

    nodes[node] = (char == "#")
  end
end

maze = Maze.new(nodes)
path = minimum_path(maze, start, goals)

solve!("The minimal path length to hit all goals is:", path.length)

path = minimum_path(maze, start, goals, return_home: true)

solve!("The minimal path length to hit all goals and come back home is:", path.length)
