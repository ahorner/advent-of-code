require "matrix"
require "rb_heap/heap"

BYTES = INPUT.split("\n").each_with_index.each_with_object({}) do |(line, t), grid|
  x, y = line.split(",").map(&:to_i)
  grid[Vector[x, y]] = t + 1
end

class Computer
  ORIGIN = Vector[0, 0]
  NEIGHBORS = [Vector[1, 0], Vector[0, 1], Vector[-1, 0], Vector[0, -1]]

  def initialize(bytes, size)
    @bytes = bytes
    @size = size
    @goal = Vector[size - 1, size - 1]
  end

  def neighbors_at(spot, time)
    NEIGHBORS.filter_map do |adjacency|
      new_spot = spot + adjacency
      next if new_spot[0] < 0 || new_spot[0] >= @size
      next if new_spot[1] < 0 || new_spot[1] >= @size
      next if @bytes[new_spot] && @bytes[new_spot] <= time

      new_spot
    end
  end

  def steps_after(time)
    queue = Heap.new { |a, b| a[0] + (@goal - a[1]).magnitude < b[0] + (@goal - b[1]).magnitude }
    queue << [0, ORIGIN]
    steps = {ORIGIN => 0}

    loop do
      break steps[@goal] if queue.empty?

      step, spot = queue.pop
      break step if spot == @goal
      next if steps[spot] < step

      neighbors_at(spot, time).each do |new_spot|
        next if steps.key?(new_spot) && steps[new_spot] <= step + 1

        steps[new_spot] = step + 1
        queue << [step + 1, new_spot]
      end
    end
  end
end

SIZE ||= 71
TIME ||= 1024

computer = Computer.new(BYTES, SIZE)
solve!(computer.steps_after(TIME))

lower = TIME
upper = BYTES.size

blocked_at = loop do
  break upper if lower + 1 == upper
  test = (lower + upper) / 2

  if computer.steps_after(test).nil?
    upper = test
  else
    lower = test
  end
end

blocking_byte = BYTES.key(blocked_at)
solve!("#{blocking_byte[0]},#{blocking_byte[1]}")
