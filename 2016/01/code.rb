class Dude
  DIRECTIONS = %w[N E S W].freeze

  attr_reader :visited

  def initialize
    @visited = []
    @facing = "N"
    @x = 0
    @y = 0
  end

  def turn(direction)
    pos = DIRECTIONS.index(@facing)
    pos += (direction == "L" ? -1 : 1)
    @facing = DIRECTIONS[pos % DIRECTIONS.length]
  end

  def move(blocks)
    blocks.times do
      case @facing
      when "N" then @y += 1
      when "E" then @x += 1
      when "S" then @y -= 1
      when "W" then @x -= 1
      end
      track_position
    end
  end

  def distance
    @x.abs + @y.abs
  end

  def track_position
    @visited << "(#{@x}, #{@y})"
  end
end

dude = Dude.new

INPUT.split(", ").each do |instruction|
  dude.turn(instruction[0])
  dude.move(instruction[1..].to_i)
end

puts "You are #{dude.distance} blocks from where you started."

position = dude.visited.detect { |pos| dude.visited.count(pos) > 1 }
puts "The first place you visited twice was #{position}"
