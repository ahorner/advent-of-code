require "matrix"

MAP = INPUT.split("\n").each_with_index.each_with_object({}) do |(row, y), grid|
  row.chars.each_with_index do |tile, x|
    grid[Vector[x, y]] = tile
  end
end

DIRECTIONS = {"^" => Vector[0, -1], ">" => Vector[1, 0], "v" => Vector[0, 1], "<" => Vector[-1, 0]}
ANGLES = DIRECTIONS.keys
OBSTRUCTION = "#"
START = "^"

def navigate(map)
  facing = START
  position = map.key(facing)
  visited = Hash.new { |h, k| h[k] = Set.new }

  loop do
    break visited if map[position].nil?
    break false if visited[position].include?(facing)

    visited[position] << facing
    test = position + DIRECTIONS[facing]

    if map[test] == OBSTRUCTION
      facing = ANGLES[(ANGLES.index(facing) + 1) % ANGLES.length]
    else
      position = test
    end
  end
end

visits = navigate(MAP)
solve!("The number of visited tiles is:", visits.count)

def obstructed(position, map)
  map.dup.tap do |updated|
    updated[position] = OBSTRUCTION
  end
end

candidates = MAP.keys & visits.keys
loops = candidates.count do |position|
  next false if MAP[position] == OBSTRUCTION
  next false if MAP[position] == START

  map = obstructed(position, MAP)
  !navigate(map)
end

solve!("The number of possible loops is:", loops)
