require "matrix"

INSTRUCTIONS = INPUT.split("\n").map do |line|
  direction, value = line.split
  [direction.to_sym, value.to_i]
end

DIRECTIONS = {
  R: Vector[1, 0],
  L: Vector[-1, 0],
  U: Vector[0, -1],
  D: Vector[0, 1],
}

def rope(knots)
  [Vector[0, 0]] * knots
end

def motion(head, tail)
  dv = head - tail
  dv.any? { |d| d.abs > 1 } ? dv.map { |d| d <=> 0 } : Vector[0, 0]
end

def path_for(rope, instructions)
  instructions.each_with_object({}) do |(direction, value), path|
    value.times do
      rope[0] += DIRECTIONS[direction]
      (1...rope.length).each { |i| rope[i] += motion(rope[i - 1], rope[i]) }
      path[rope.last] = true
    end
  end
end

path = path_for(rope(2), INSTRUCTIONS)
solve!(
  "The number of rooms visited by the 2-knot tail is:",
  path.count,
)

path = path_for(rope(10), INSTRUCTIONS)
solve!(
  "The number of rooms visited by the 10-knot tail is:",
  path.count,
)
