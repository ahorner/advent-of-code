require "set"

class Room
  attr_accessor :neighbors
  attr_reader :position

  def initialize(position)
    @position = position
    @neighbors = []
  end

  def move(vector)
    @position.zip(vector).map(&:sum)
  end
end

class Base
  DIRECTIONS = {
    "N" => [0, -1],
    "E" => [1, 0],
    "S" => [0, 1],
    "W" => [-1, 0]
  }.freeze

  attr_accessor :rooms

  def initialize
    @rooms = {}
  end

  def [](position)
    @rooms[position]
  end

  def add_room(position)
    @rooms[position] ||= Room.new(position)
  end

  def add_door(room, direction)
    next_room = add_room(room.move(DIRECTIONS[direction]))
    room.neighbors << next_room
    next_room.neighbors << room

    next_room
  end

  def explore_from(room)
    explored = {room => 0}
    queue = [[room, 0]]

    loop do
      break if queue.empty?

      room, steps = queue.shift
      room.neighbors.each do |neighbor|
        next if explored.key?(neighbor) && explored[neighbor] <= steps + 1

        explored[neighbor] = steps + 1
        queue << [neighbor, steps + 1]
      end
    end

    explored
  end
end

base = Base.new
origin = base.add_room([0, 0])
current = origin
branches = []

INPUT.chars.each do |step|
  case step
  when "N", "E", "S", "W" then current = base.add_door(current, step)
  when "(" then branches << current
  when "|" then current = branches.last
  when ")" then current = branches.pop
  end
end

distances = base.explore_from(origin)

solve!("The shortest path to the furthest room is:", distances.values.max)
solve!("The number of rooms 1000 steps or more away is:", distances.values.count { |i| i >= 1000 })
