INSTRUCTION_MATCHER = /^(?<direction>[A-Z])(?<count>\d+)$/.freeze
INSTRUCTIONS = INPUT.split("\n").map { |line| line.match(INSTRUCTION_MATCHER) }.freeze

class Ship
  COMPASS = {
    "N" => [0, -1],
    "E" => [1, 0],
    "S" => [0, 1],
    "W" => [-1, 0],
  }.freeze

  def initialize(origin: [0, 0], direction: [1, 0])
    @x = origin[0]
    @y = origin[1]
    @dx = direction[0]
    @dy = direction[1]
  end

  def distance
    @x.abs + @y.abs
  end

  def follow!(direction, amount)
    case direction
    when "F" then amount.times { forward! }
    when "R" then turn!(amount)
    when "L" then turn!(-amount)
    else amount.times { move!(*COMPASS[direction]) }
    end
  end

  def turn!(amount)
    (amount.abs / 90).times do
      @dx, @dy = amount > 0 ? [-@dy, @dx] : [@dy, -@dx]
    end
  end

  def forward!
    @x += @dx
    @y += @dy
  end

  def move!(dx, dy)
    @x += dx
    @y += dy
  end
end

def navigate!(ship)
  INSTRUCTIONS.each do |instruction|
    ship.follow!(instruction[:direction], instruction[:count].to_i)
  end
end

ship = Ship.new
navigate!(ship)

solve!("The distance to the final location is:", ship.distance)

class WaypointShip < Ship
  def initialize(origin: [0, 0], waypoint: [10, -1])
    super(origin: origin, direction: waypoint)
  end

  def move!(dx, dy)
    @dx += dx
    @dy += dy
  end
end

ship = WaypointShip.new
navigate!(ship)

solve!("The distance to the final waypointed location is:", ship.distance)
