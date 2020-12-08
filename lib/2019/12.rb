MATCHER = /<x=(?<x>-?\d+), y=(?<y>-?\d+), z=(?<z>-?\d+)>/.freeze
MOONS = INPUT.split("\n").map { |line| line.match(MATCHER).captures.map(&:to_i) }.freeze

class Moon
  attr_reader :position

  def initialize(position)
    @position = position
    @velocity = [0, 0, 0]
  end

  def pull!(moon)
    @position.each_with_index do |coord, i|
      @velocity[i] += moon.position[i] <=> coord
    end
  end

  def move!
    @position = @position.zip(@velocity).map(&:sum)
  end

  def energy
    potential_energy * kinetic_energy
  end

  def potential_energy
    @position.map(&:abs).sum
  end

  def kinetic_energy
    @velocity.map(&:abs).sum
  end
end

def tick!(moons)
  moons.combination(2) do |first, second|
    first.pull!(second)
    second.pull!(first)
  end

  moons.each(&:move!)
end

moons = MOONS.map { |position| Moon.new(position) }

STEPS ||= 1_000
STEPS.times { tick!(moons) }

solve!("The total energy after 1000 steps is:", moons.sum(&:energy))

moons = MOONS.map { |position| Moon.new(position) }
cycles = [nil, nil, nil]
ticks = 1

loop do
  tick!(moons)
  ticks += 1

  3.times do |axis|
    cycled = MOONS.each_with_index.all? { |pos, i| pos[axis] == moons[i].position[axis] }
    cycles[axis] ||= ticks if cycled
  end

  break if cycles.all?
end

solve!("The minimum number of steps to repeat the cycle is:", cycles.reduce(1, :lcm))
