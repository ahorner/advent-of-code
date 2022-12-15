NEIGHBORS = {
  "ne" => [0, -1, 1],
  "nw" => [-1, 0, 1],
  "se" => [1, 0, -1],
  "sw" => [0, 1, -1],
  "e" => [1, -1, 0],
  "w" => [-1, 1, 0]
}.freeze

DIRECTIONS = INPUT.split("\n").map { |line| line.scan(Regexp.union(NEIGHBORS.keys)).to_a }.freeze
FLOOR = DIRECTIONS.each_with_object({}) do |instructions, floor|
  steps = instructions.map { |step| NEIGHBORS[step] }
  coords = [0, 0, 0].zip(*steps).map(&:sum)

  floor[coords] = !floor[coords]
end.freeze

solve!("The initial number of black tiles is:", FLOOR.values.count(true))

def neighbors_for(coords)
  NEIGHBORS.map { |_, change| coords.zip(change).map(&:sum) }
end

def flipped(floor)
  floor.each_with_object({}) do |(coords, value), updated|
    next unless value

    count = neighbors_for(coords).count do |neighbor|
      next true if floor[neighbor]

      updated[neighbor] = neighbors_for(neighbor).count { |n| floor[n] } == 2
      false
    end

    updated[coords] = count > 0 && count <= 2
  end
end

floor = FLOOR
100.times { floor = flipped(floor) }
solve!("The number of black tiles after 100 days is:", floor.values.count(true))
