class Cuboid
  attr_reader :x, :y, :z

  def initialize(x:, y:, z:)
    @x = x
    @y = y
    @z = z
  end

  def size
    @x.size * @y.size * @z.size
  end

  def &(other)
    xint = intersection(x, other.x)
    yint = intersection(y, other.y)
    zint = intersection(z, other.z)

    return nil unless xint && yint && zint

    Cuboid.new(x: xint, y: yint, z: zint)
  end

  private

  def intersection(first, second)
    return nil if first.end < second.begin || second.end < first.begin

    [first.begin, second.begin].max..[first.end, second.end].min
  end
end

def unique_cubes(cuboid, overlays)
  overwrites = overlays.filter_map { |overlay| cuboid & overlay }
  overwritten = overwrites.each_index.sum { |i| unique_cubes(overwrites[i], overwrites.drop(i + 1)) }

  cuboid.size - overwritten
end

def active_cubes(steps)
  cuboids = steps.map(&:last)
  steps.each_with_index.sum do |(state, cuboid), i|
    next 0 unless state

    unique_cubes(cuboid, cuboids.drop(i + 1))
  end
end

STEP_MATCHER = /
  (?<state>on|off)\s
  x=(?<x>-?\d+\.\.-?\d+),
  y=(?<y>-?\d+\.\.-?\d+),
  z=(?<z>-?\d+\.\.-?\d+)
/x.freeze

STEPS = INPUT.split("\n").map do |line|
  match = line.match(STEP_MATCHER)

  [
    match[:state] == "on",
    Cuboid.new(
      x: eval(match[:x]),
      y: eval(match[:y]),
      z: eval(match[:z]),
    ),
  ]
end.freeze

INITIALIZATION_REGION = Cuboid.new(x: -50..50, y: -50..50, z: -50..50).freeze
INITIALIZATION_STEPS = STEPS.filter_map do |state, cuboid|
  initializer = cuboid & INITIALIZATION_REGION
  next unless initializer

  [state, initializer]
end

solve!("The number of cubes on after initialization is:", active_cubes(INITIALIZATION_STEPS))
solve!("The number of cubes on after a full reboot is:", active_cubes(STEPS))
