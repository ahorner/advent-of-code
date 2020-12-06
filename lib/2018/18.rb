require "set"

COLLECTION_AREA = INPUT.split("\n").map(&:chars).freeze
SIZE = COLLECTION_AREA.size

NEIGHBORS = [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]].freeze
ACRES = { open: ".", forest: "|", lumberyard: "#" }.freeze
TRANSITIONS = {
  ACRES[:open] => ->(n) { n.count(ACRES[:forest]) >= 3 ? ACRES[:forest] : ACRES[:open] },
  ACRES[:forest] => ->(n) { n.count(ACRES[:lumberyard]) >= 3 ? ACRES[:lumberyard] : ACRES[:forest] },
  ACRES[:lumberyard] => lambda do |n|
    n.count(ACRES[:forest]) > 0 && n.count(ACRES[:lumberyard]) > 0 ? ACRES[:lumberyard] : ACRES[:open]
  end,
}.freeze

def next_state(area)
  new_area = Array.new(SIZE) { Array.new(SIZE) }

  area.each_with_index do |row, y|
    row.each_with_index do |acre, x|
      neighbors = NEIGHBORS.map do |dx, dy|
        next if x + dx >= SIZE || x + dx < 0
        next if y + dy >= SIZE || y + dy < 0

        area[y + dy][x + dx]
      end.compact

      new_area[y][x] = TRANSITIONS[acre].call(neighbors)
    end
  end

  new_area
end

def iterate(area, minutes)
  seen = []

  minutes.times do |_i|
    area = next_state(area)
    seen.include?(area) ? break : seen << area
  end

  starts_at = seen.index(area)
  looped = seen[starts_at..]
  looped[(minutes - starts_at - 1) % looped.size]
end

def resource_value(area)
  tiles = area.flatten
  tiles.count(ACRES[:forest]) * tiles.count(ACRES[:lumberyard])
end

area = iterate(COLLECTION_AREA, 10)
solve!("The resource value after 10 minutes is:", resource_value(area))

area = iterate(COLLECTION_AREA, 1_000_000_000)
solve!("The resource value after 1B minutes is:", resource_value(area))
