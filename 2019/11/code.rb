require_relative "../shared/intcode"

VECTORS = {
  up: [0, -1],
  left: [-1, 0],
  down: [0, 1],
  right: [1, 0],
}
DIRECTIONS = [:up, :right, :down, :left]

def rotate_by(direction, rotate)
  rotation = rotate == 0 ? -1 : 1
  (direction + rotation) % DIRECTIONS.size
end

def move_by(x, y, direction)
  vector = VECTORS[DIRECTIONS[direction]]
  [x + vector[0], y + vector[1]]
end

def run!(hull)
  robot = Computer.new(INTCODE)
  x, y = 0, 0
  direction = 0

  loop do
    color, rotate = robot.run(inputs: [hull[[x, y]]])

    hull[[x, y]] = color
    direction = rotate_by(direction, rotate)
    x, y = move_by(x, y, direction)

    break unless robot.running?
  end
end

hull = Hash.new(0)
run!(hull)
puts "The number of painted panels is:", hull.count, "\n"

hull = Hash.new(0)
hull[[0, 0]] = 1
run!(hull)

minx, maxx = hull.keys.map(&:first).minmax
miny, maxy = hull.keys.map(&:last).minmax

puts "The registration identifier is:", "\n"

(miny..maxy).each do |j|
  (minx..maxx).each { |i| print(hull[[i, j]] == 0 ? "." : "#") }
  print "\n"
end
