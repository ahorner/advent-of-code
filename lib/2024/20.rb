require "matrix"

TRACK = INPUT.split("\n").each_with_index.each_with_object({}) do |(line, y), grid|
  line.chars.each_with_index do |c, x|
    grid[Vector[x, y]] = c
  end
end

ADJACENCIES = [Vector[1, 0], Vector[0, 1], Vector[-1, 0], Vector[0, -1]]

START = TRACK.key("S")
GOAL = TRACK.key("E")
PATH = {START => 0}

position = START
steps = 0

loop do
  break if position == GOAL
  move = ADJACENCIES.detect do |move|
    next if PATH[position + move]
    TRACK[position + move] != "#"
  end

  position += move
  PATH[position] = steps
  steps += 1
end

def distance(from, to)
  (to - from).map(&:abs).sum
end

def shortcuts(path, savings, length)
  max_steps = path.values.max
  minx, maxx = path.keys.map { |v| v[0] }.minmax
  miny, maxy = path.keys.map { |v| v[1] }.minmax

  path.sum do |from, time|
    next 0 if max_steps - time < savings

    ((from[0] - length)..(from[0] + length)).sum do |x|
      next 0 if x < minx || x > maxx
      dy = length - (x - from[0]).abs

      ((from[1] - dy)..(from[1] + dy)).count do |y|
        next if y < miny || y > maxy

        to = Vector[x, y]
        next unless path.key?(to)
        next if path[to] - time < savings

        d = distance(from, to)
        d <= length && (path[to] - time - d + 1) >= savings
      end
    end
  end
end

SAVINGS ||= 100
solve!("The number of 2-picosecond shortcuts is:", shortcuts(PATH, SAVINGS, 2))
solve!("The number of 20-picosecond shortcuts is:", shortcuts(PATH, SAVINGS, 20))
