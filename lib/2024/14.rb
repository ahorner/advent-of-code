require "matrix"

ROBOT_MATCHER = /\Ap=(?<px>-?\d+),(?<py>-?\d+) v=(?<vx>-?\d+),(?<vy>-?\d+)\z/
ROBOTS = INPUT.split("\n").map do |line|
  robot = line.match(ROBOT_MATCHER)

  {
    position: Vector[robot[:px].to_i, robot[:py].to_i],
    velocity: Vector[robot[:vx].to_i, robot[:vy].to_i]
  }
end

TIME = 100

WIDTH ||= 101
HEIGHT ||= 103

def final_position(width, height, robot, time)
  position = robot[:position]
  position += robot[:velocity] * time

  Vector[position[0] % width, position[1] % height]
end

QUADRANTS = {[-1, -1] => :ul, [-1, 1] => :ur, [1, -1] => :bl, [1, 1] => :br}

def quadrant(width, height, position)
  h = position[0] <=> width / 2
  v = position[1] <=> height / 2

  QUADRANTS[[h, v]]
end

positions = ROBOTS.map { |robot| final_position(WIDTH, HEIGHT, robot, 100) }
groups = positions.group_by { |position| quadrant(WIDTH, HEIGHT, position) }.reject { |k, _| k.nil? }

solve!("The safety factor after 100 seconds is:", groups.values.map(&:count).inject(:*))

tree_at = (TIME..Float::INFINITY).detect do |t|
  positions = Hash.new(0)

  ROBOTS.none? do |robot|
    position = final_position(WIDTH, HEIGHT, robot, t)
    (positions[position] += 1) > 1
  end
end

solve!("The robots form a Christmas Tree at:", tree_at)
