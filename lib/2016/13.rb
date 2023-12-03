class Maze
  def initialize(magic_number)
    @magic_number = magic_number
  end

  def wall?((x, y))
    sum = (x * x) + (3 * x) + (2 * x * y) + y + (y * y)
    (sum + @magic_number).to_s(2).scan("1").size.odd?
  end

  def adjacent_spots((x, y))
    [
      [x + 1, y],
      ([x - 1, y] if x - 1 >= 0),
      [x, y + 1],
      ([x, y - 1] if y - 1 >= 0)
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

  def reachable(start, maximum_steps)
    spots = []
    traverse(start, maximum_steps: maximum_steps) { |spot| spots << spot }

    spots
  end

  private

  def traverse(start, estimator: proc { 0 }, maximum_steps: 10_000)
    found = {}
    queue = PriorityQueue.new
    queue.add(1, [start, [], 0])

    loop do
      break if queue.empty?

      spot, path, steps = queue.next
      next if found[spot]
      next if steps > maximum_steps

      yield spot, path

      found[spot] = true
      @maze.adjacent_spots(spot).each do |new_spot|
        next if found[new_spot]

        new_steps = steps + 1

        queue.add(
          new_steps + estimator.call(new_spot),
          [new_spot, [*path, new_spot], new_steps]
        )
      end
    end
  end
end

NUMBER = INPUT.to_i
START = [1, 1].freeze
TARGET ||= [31, 39].freeze
MAXIMUM_STEPS = 50

maze = Maze.new(NUMBER)
pathfinder = Pathfinder.new(maze)

path = pathfinder.path(START, TARGET)
solve!("The minimal path length from #{START} to #{TARGET} is:", path.length)

nodes = pathfinder.reachable(START, MAXIMUM_STEPS)
solve!("The number of spots reachable within #{MAXIMUM_STEPS} steps is:", nodes.length)
