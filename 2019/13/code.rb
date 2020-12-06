require_relative "../shared/intcode"

TILES = [".", "|", "#", "_", "o"].freeze

def render(tiles)
  screen = Hash.new(0)
  score = 0

  tiles.each_slice(3) do |x, y, value|
    if x == -1 && y == 0
      score = value
    else
      screen[[x, y]] = value
    end
  end

  [screen, score]
end

cabinet = Computer.new(INTCODE)
screen, = render(cabinet.run)
puts "The total number of blocks is:", screen.values.count { |tile| tile == TILES.index("#") }, "\n"

playable = INTCODE.dup
playable[0] = 2
cabinet = Computer.new(playable)

final_score = loop do
  ball, = screen.detect { |_coords, tile| tile == TILES.index("o") }
  paddle, = screen.detect { |_coords, tile| tile == TILES.index("_") }
  joystick = ball[0] <=> paddle[0]

  updates, score = render(cabinet.run(inputs: [joystick]))
  screen.merge!(updates)

  break score if screen.values.none? { |tile| tile == TILES.index("#") }
end

puts "The score after breaking all blocks is:", final_score
