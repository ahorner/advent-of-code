class Particle
  PARTICLE_MATCHER = /p=<(?<position>.+)>, v=<(?<velocity>.+)>, a=<(?<acceleration>.+)>/.freeze

  attr_reader :id, :position

  def initialize(id, line)
    @id = id

    traits = PARTICLE_MATCHER.match(line)
    @position = traits[:position].split(",").map(&:to_i)
    @velocity = traits[:velocity].split(",").map(&:to_i)
    @acceleration = traits[:acceleration].split(",").map(&:to_i)
  end

  def displacement
    @position.map(&:abs).sum
  end

  def acceleration
    @acceleration.map(&:abs).sum
  end

  def speed
    @velocity.map(&:abs).sum
  end

  def tick!
    @velocity = @velocity.zip(@acceleration).map(&:sum)
    @position = @position.zip(@velocity).map(&:sum)
  end
end

particles = []
INPUT.split("\n").each_with_index do |line, i|
  particles << Particle.new(i, line)
end

closest = particles.min_by { |p| [p.acceleration, p.speed, p.displacement] }
puts "The long-term closest particle is:", closest.id, nil

100.times do
  particles.each(&:tick!)

  counts = particles.each_with_object(Hash.new(0)) { |p, c| c[p.position] += 1 }
  particles.reject! { |p| counts[p.position] > 1 }
end

puts "The number of particles remaining after collisions is:", particles.count
