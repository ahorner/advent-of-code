NORTH_ANGLES = %w[7 | F].freeze
ANGLES = {
  "|" => ->(x, y) { [[x, y - 1], [x, y + 1]] },
  "-" => ->(x, y) { [[x - 1, y], [x + 1, y]] },
  "L" => ->(x, y) { [[x, y - 1], [x + 1, y]] },
  "J" => ->(x, y) { [[x, y - 1], [x - 1, y]] },
  "7" => ->(x, y) { [[x, y + 1], [x - 1, y]] },
  "F" => ->(x, y) { [[x, y + 1], [x + 1, y]] }
}.freeze

Pipe = Data.define(:angle, :connections) do
  def connects_to?(position)
    connections.include?(position)
  end

  def north?
    NORTH_ANGLES.include?(angle)
  end
end

starting_position = []
MAP = INPUT.split("\n").each_with_index.each_with_object({}) do |(line, y), map|
  line.chars.each_with_index do |angle, x|
    if angle == "S"
      starting_position = [x, y]
      next
    end

    next unless ANGLES.key?(angle)

    connections = ANGLES[angle].call(x, y)
    map[[x, y]] = Pipe.new(angle:, connections:)
  end
end

connections = MAP.select { |_, pipe| pipe.connects_to?(starting_position) }.map(&:first)
angle = ANGLES.keys.detect do |a|
  connected = ANGLES[a].call(*starting_position)
  connected.all? { |conn| connections.include?(conn) }
end

MAP[starting_position] = Pipe.new(angle:, connections:)

def distance_map(map, start_at)
  distances = {}
  tests = [[start_at, 0]]

  loop do
    break distances if tests.empty?

    test, steps = tests.shift
    next if distances.key?(test)

    tests += map[test].connections.map { |conn| [conn, steps + 1] }
    distances[test] = steps
  end
end

distances = distance_map(MAP, starting_position)
solve!("The step count to the furthest pipe is:", distances.values.max)

def enclosed_tiles(loop_map)
  xmin, xmax = loop_map.keys.map(&:first).minmax
  ymin, ymax = loop_map.keys.map(&:last).minmax
  enclosed = 0

  (ymin..ymax).each do |y|
    north = 0
    (xmin..xmax).each do |x|
      if !loop_map[[x, y]]
        enclosed += 1 if north.odd?
      elsif loop_map[[x, y]].north?
        north += 1
      end
    end
  end

  enclosed
end

solve!("The number of enclosed tiles is:", enclosed_tiles(MAP.slice(*distances.keys)))
