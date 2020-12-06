class Sled
  def initialize(map)
    @map = map
    @x = 0
    @y = 0

    drop_gift
  end

  def move(instruction)
    case instruction
    when ">" then @x += 1
    when "<" then @x -= 1
    when "^" then @y += 1
    when "v" then @y -= 1
    end

    drop_gift
  end

  def drop_gift
    @map[[@x, @y]] += 1
  end
end

def instructions
  INPUT.split("")
end

def base_map
  Hash.new(0)
end

def flyover
  map = base_map

  santa = Sled.new(map)
  instructions.each { |step| santa.move(step) }

  map
end

puts "Flyover: #{flyover.count} happy houses"

def robo_flyover
  map = base_map

  santa = Sled.new(map)
  robo_santa = Sled.new(map)

  robo = false

  instructions.each do |step|
    robo ? robo_santa.move(step) : santa.move(step)
    robo = !robo
  end

  map
end

puts "Tandem Robo-flyover: #{robo_flyover.count} happy houses"
