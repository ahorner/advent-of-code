require "matrix"
require "set"

class Valley
  Blizzard = Struct.new(:position, :direction)

  DIRECTIONS = {
    "<" => Vector[-1, 0],
    ">" => Vector[1, 0],
    "v" => Vector[0, 1],
    "^" => Vector[0, -1]
  }

  attr_reader :height, :width

  def initialize(diagram)
    area = diagram.split("\n")

    @height = area.size - 2
    @width = area.first.size - 2
    @blizzards = []

    area[1..-2].each_with_index do |line, y|
      line[1..-2].chars.each_with_index do |tile, x|
        @blizzards << Blizzard.new(Vector[x, y], DIRECTIONS[tile]) if DIRECTIONS.key?(tile)
      end
    end
  end

  def valid?(position, time)
    return false if position[0] < 0 || position[0] >= width
    return false if position[1] < 0 || position[1] >= height

    !blizzards_at(time)[position]
  end

  def entrance
    Vector[0, -1]
  end

  def goal
    Vector[width - 1, height]
  end

  private

  def blizzards_at(time)
    @blizzards_at ||= {}
    @blizzards_at[time % height.lcm(width)] ||= @blizzards.each_with_object({}) do |blizzard, map|
      computed = blizzard.position + (blizzard.direction * time)
      position = Vector[computed[0] % width, computed[1] % height]

      map[position] = true
    end
  end
end

class Expedition
  def initialize(valley)
    @valley = valley
  end

  def quickest_route(at: 0, from: @valley.entrance, to: @valley.goal)
    positions = Set.new([from])
    time = at

    loop do
      break time if positions.include?(to)

      next_positions = Set.new
      positions.each do |position|
        Valley::DIRECTIONS.each_value do |dv|
          next if next_positions.include?(position + dv)
          next unless position + dv == to || @valley.valid?(position + dv, time + 1)
          next_positions << position + dv
        end

        next unless position == from || @valley.valid?(position, time + 1)
        next_positions << position
      end

      positions = next_positions
      time += 1
    end
  end
end

VALLEY = Valley.new(INPUT)
EXPEDITION = Expedition.new(VALLEY)

time = EXPEDITION.quickest_route
solve!(
  "The fastest time possible through the blizzards is:",
  time
)

time = EXPEDITION.quickest_route(at: time, from: VALLEY.goal, to: VALLEY.entrance)
time = EXPEDITION.quickest_route(at: time)
solve!(
  "The fastest time including a return trip is:",
  time
)
