require "matrix"
require "rb_heap/heap"

class City
  DIRECTIONS = {
    n: Vector[0, -1],
    e: Vector[1, 0],
    s: Vector[0, 1],
    w: Vector[-1, 0]
  }.freeze

  def initialize(map)
    @map = map
  end

  def [](block)
    @map[block]
  end

  def destinations(origin, turns)
    turns.filter_map do |direction|
      destination = origin + DIRECTIONS[direction]
      next unless @map.key?(destination)

      [destination, direction]
    end
  end
end

class Crucible
  TURNS = {n: %i[e w], e: %i[n s], s: %i[e w], w: %i[n s]}.freeze

  def initialize(city, min: 1, max: 3)
    @city = city
    @min = min
    @max = max
  end

  def turns_for(path)
    return %i[n e s w] if path.empty?

    direction = path.last

    if path.size >= @min && path.last(@min).all? { |d| d == direction }
      turns = TURNS[direction]
      (path.size >= @max && path.last(@max).all? { |d| d == direction }) ? turns : turns + [direction]
    else
      [direction]
    end
  end

  def heat_loss(from:, to:)
    queue = Heap.new { |a, b| a[0] < b[0] }
    queue << [0, from, []]

    losses = {}

    loop do
      if queue.empty?
        goals = losses.select { |k, _| k[0] == to && k[2] >= @min }
        break goals.map(&:last).min
      end

      loss, block, path = queue.pop
      @city.destinations(block, turns_for(path)).each do |dest, dir|
        new_loss = loss + @city[dest]
        new_path = path + [dir]

        steps = new_path.count(dir)
        key = [dest, dir, steps]

        next if losses.key?(key) && losses[key][0] <= new_loss

        losses[key] = new_loss
        next if dest == to

        queue << [new_loss, dest, new_path.last(@max)]
      end
    end
  end
end

MAP = INPUT.split("\n").each_with_object({}).with_index do |(line, map), y|
  line.chars.each_with_index do |c, x|
    map[Vector[x, y]] = c.to_i
  end
end.freeze

START = Vector[0, 0]
GOAL = MAP.keys.max_by(&:magnitude)

city = City.new(MAP)
crucible = Crucible.new(city)
heat_loss = crucible.heat_loss(from: START, to: GOAL)

solve!("The minimum heat loss on the trip is:", heat_loss)

ultra_crucible = Crucible.new(city, min: 4, max: 10)
heat_loss = ultra_crucible.heat_loss(from: START, to: GOAL)

solve!("The minimum heat loss for an ultra crucible is:", heat_loss)
