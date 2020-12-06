require_relative "./shared/intcode"

class Blueprint
  DIRECTIONS = [[0, -1], [0, 1], [-1, 0], [1, 0]].freeze
  DROID = -1
  WALL = 0
  OXYGEN_SYSTEM = 2

  def initialize(map)
    @map = map
  end

  def droid
    @map.key(DROID)
  end

  def oxygen_system
    @map.key(OXYGEN_SYSTEM)
  end

  def wall?(coords)
    @map[coords] == WALL
  end

  def adjacent_coords((x, y))
    DIRECTIONS.map { |i, j| [x + i, y + j] }.reject { |coords| wall?(coords) }
  end
end

class Droid
  MOVEMENTS = Hash[[1, 2, 3, 4].zip(Blueprint::DIRECTIONS)].freeze
  REVERSE = { 1 => 2, 2 => 1, 3 => 4, 4 => 3 }.freeze
  SUCCESS_CODES = [1, 2].freeze

  def initialize(_program)
    @computer = Computer.new(INTCODE)
    @x = 0
    @y = 0
  end

  def blueprint
    map = { [@x, @y] => Blueprint::DROID }
    queues = { [@x, @y] => MOVEMENTS.keys }
    path = []

    loop do
      break if queues.all? { |_, t| t.empty? }

      if queues[[@x, @y]].empty?
        backtrack = REVERSE[path.pop]
        @computer.run(inputs: [backtrack])
        @x, @y = move(backtrack)
        next
      end

      direction = queues[[@x, @y]].shift
      newx, newy = move(direction)

      output = @computer.run(inputs: [direction]).last
      map[[newx, newy]] ||= output

      next unless SUCCESS_CODES.include?(output)

      @x = newx
      @y = newy
      queues[[@x, @y]] ||= MOVEMENTS.keys - [REVERSE[direction]]
      path << direction
    end

    Blueprint.new(map)
  end

  private

  def move(direction)
    [@x + MOVEMENTS[direction][0], @y + MOVEMENTS[direction][1]]
  end
end

class Pathfinder
  class PriorityQueue
    def initialize
      @list = []
    end

    def add(priority, item)
      @list << [priority, @list.length, item]
      @list.sort!
    end

    def next
      @list.shift[2]
    end

    def empty?
      @list.empty?
    end
  end

  def initialize(map)
    @map = map
  end

  def path(start, target)
    estimator = proc { |(x, y)| (target[0] - x).abs + (target[1] - y).abs }
    traverse(start, estimator: estimator) { |spot, path| return path if spot == target }
  end

  private

  def traverse(start, estimator: proc { 0 })
    found = {}
    queue = PriorityQueue.new
    queue.add(1, [start, [], 0])

    loop do
      break if queue.empty?

      spot, path, steps = queue.next
      next if found[spot]

      yield spot, path

      found[spot] = true
      @map.adjacent_coords(spot).each do |new_spot|
        next if found[new_spot]

        new_steps = steps + 1

        queue.add(
          new_steps + estimator.call(new_spot),
          [new_spot, [*path, new_spot], new_steps],
        )
      end
    end
  end
end

class OxygenSystem
  def initialize(map)
    @map = map
  end

  def fill_from(target)
    oxygenated = {}
    sources = [target]
    minutes = 0

    loop do
      sources = sources.flat_map do |source|
        oxygenated[source] = true
        @map.adjacent_coords(source).reject { |spot| oxygenated[spot] }
      end

      break minutes if sources.empty?

      minutes += 1
    end
  end
end

droid = Droid.new(INTCODE)
blueprint = droid.blueprint

pathfinder = Pathfinder.new(blueprint)
path = pathfinder.path(blueprint.droid, blueprint.oxygen_system)
puts "The minimum path length to the oxygen system is:", path.length, "\n"

oxygen = OxygenSystem.new(blueprint)
minutes = oxygen.fill_from(blueprint.oxygen_system)
puts "The number of minutes it will take to fill the map with oxygen is:", minutes
