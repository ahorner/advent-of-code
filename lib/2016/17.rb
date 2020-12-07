require "digest"

class Maze
  OPEN_MATCHER = /[b-f]/.freeze

  def initialize(width = 4, height = 4)
    @grid = {}
    @width = width
    @height = height
  end

  def adjacent_spots((x, y, _), string)
    [
      [x, y - 1, :U],
      [x, y + 1, :D],
      [x - 1, y, :L],
      [x + 1, y, :R],
    ].select do |(i, j, direction)|
      open?(string, direction) &&
        i >= 0 && i < @width &&
        j >= 0 && j < @height
    end
  end

  def open?(string, direction)
    @grid[string] ||= begin
      digest = Digest::MD5.hexdigest(string)

      {
        U: digest[0] =~ OPEN_MATCHER,
        D: digest[1] =~ OPEN_MATCHER,
        L: digest[2] =~ OPEN_MATCHER,
        R: digest[3] =~ OPEN_MATCHER,
      }
    end

    @grid[string][direction]
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

  def min_path(start, target)
    min = traverse(start, target) { |path| break path }
    path_string(min).delete(start.last)
  end

  def max_path(start, target)
    max = nil

    traverse(start, target) do |path|
      max = [max, path].compact.max_by(&:length)
    end

    path_string(max).delete(start.last)
  end

  private

  def path_string(path)
    path.map(&:last).join
  end

  def traverse(start, target, maximum_steps: 1_000)
    queue = PriorityQueue.new
    queue.add(1, [start, [start], 0])

    until queue.empty?
      spot, path, steps = queue.next
      if target == [spot[0], spot[1]]
        yield path
        next
      end

      @maze.adjacent_spots(spot, path_string(path)).each do |new_spot|
        new_steps = steps + 1
        next if new_steps > maximum_steps

        queue.add(
          new_steps,
          [new_spot, [*path, new_spot], new_steps],
        )
      end
    end
  end
end

START = [0, 0].freeze
TARGET = [3, 3].freeze

maze = Maze.new
pathfinder = Pathfinder.new(maze)

min_path = pathfinder.min_path([*START, INPUT], TARGET)
solve!("The minimum path is:", min_path)

max_path = pathfinder.max_path([*START, INPUT], TARGET)
solve!("The maximum path length is:", max_path.length)
