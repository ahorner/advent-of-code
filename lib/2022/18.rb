require "matrix"

class Droplet
  SIDES = [
    Vector[1, 0, 0],
    Vector[-1, 0, 0],
    Vector[0, 1, 0],
    Vector[0, -1, 0],
    Vector[0, 0, 1],
    Vector[0, 0, -1]
  ]

  attr_reader :positions

  def initialize(positions)
    @positions = positions
    @cubes = positions.to_h { |pos| [pos, true] }

    minx, maxx = positions.map { |c| c[0] }.minmax
    miny, maxy = positions.map { |c| c[1] }.minmax
    minz, maxz = positions.map { |c| c[2] }.minmax
    @ranges = [[minx, maxx], [miny, maxy], [minz, maxz]]

    @trapped = {}
  end

  def [](position)
    @cubes[position]
  end

  def external?(position)
    @ranges.each_with_index.any? do |(min, max), i|
      position[i] < min || position[i] > max
    end
  end

  def trapped?(position)
    return false if external?(position)

    queue = SIDES.map { |side| position + side }
    tested = {position => true}

    trapped = loop do
      position = queue.shift
      break true if position.nil?

      next if @cubes[position]
      next if tested[position]
      tested[position] = true

      break @trapped[position] if @trapped.key?(position)
      break false if external?(position)

      SIDES.each do |side|
        new_position = position + side
        queue << new_position unless tested[new_position] || @cubes[new_position]
      end
    end

    tested.each_key { |pos| @trapped[pos] = trapped }
    trapped
  end
end

DROPLET = Droplet.new(
  INPUT.split("\n").map do |line|
    Vector[*line.split(",").map(&:to_i)]
  end
)

exposed = DROPLET.positions.flat_map do |cube|
  Droplet::SIDES.filter_map do |side|
    cube + side unless DROPLET[cube + side]
  end
end
solve!(
  "The surface area of the lava droplet is:",
  exposed.count
)

external = exposed.reject { |position| DROPLET.trapped?(position) }
solve!(
  "The exterior surface area of the lava droplet is:",
  external.count
)
