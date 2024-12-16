require "matrix"

layout, instructions = INPUT.split("\n\n")

def map_from(layout)
  layout.split("\n").each_with_index.each_with_object({}) do |(line, y), grid|
    line.chars.each_with_index do |c, x|
      grid[Vector[x, y]] = c
    end
  end
end

INSTRUCTIONS = instructions.tr("\n", "").chars
DIRECTIONS = {">" => Vector[1, 0], "v" => Vector[0, 1], "<" => Vector[-1, 0], "^" => Vector[0, -1]}

ROBOT = "@"
WALL = "#"
CRATE = "O"
CRATE_L = "["
CRATE_R = "]"
EMPTY = "."

def after_move(map, move)
  robot = map.key(ROBOT)
  tests = [robot]
  stack = [robot]

  can_move = loop do
    break false if tests.any? { |test| map[test + move] == WALL }

    tests = tests.reject { |test| map[test + move] == EMPTY }
    break true if tests.empty?

    tests = tests.filter_map do |test|
      if map[test + move] == CRATE
        stack << (test + move)
        test + move
      elsif map[test + move] == CRATE_L
        stack << (test + move)
        stack << (test + Vector[1, 0] + move)

        (move == Vector[1, 0]) ? test + move * 2 : [test + move, test + move + Vector[1, 0]]
      elsif map[test + move] == CRATE_R
        stack << (test + move)
        stack << (test + Vector[-1, 0] + move)

        (move == Vector[-1, 0]) ? test + move * 2 : [test + move, test + move + Vector[-1, 0]]
      end
    end.flatten.uniq
  end

  if can_move
    updated = map.dup

    stack.uniq.reverse_each do |from|
      to = from + move
      to_value = updated[to]
      updated[to] = updated[from]
      updated[from] = to_value
    end

    updated
  else
    map
  end
end

def gps_total(map)
  map.sum do |position, tile|
    (tile == CRATE || tile == CRATE_L) ? position[1] * 100 + position[0] : 0
  end
end

map = map_from(layout)
INSTRUCTIONS.each do |instruction|
  map = after_move(map, DIRECTIONS[instruction])
end

solve!("The total of GPS coordinates after moving is:", gps_total(map))

def widen(layout)
  layout
    .gsub("#", "##")
    .gsub(".", "..")
    .gsub("O", "[]")
    .gsub("@", "@.")
end

map = map_from(widen(layout))
INSTRUCTIONS.each do |instruction|
  map = after_move(map, DIRECTIONS[instruction])
end

solve!("The total of wide-map GPS coordinates after moving is:", gps_total(map))
