require_relative "../shared/intcode"

class Room
  NAME_MATCHER = /^== (?<name>.+) ==$/.freeze
  DIRECTIONS = %w[north east south west].freeze
  TRAPS = ["escape pod", "giant electromagnet", "infinite loop", "molten lava", "photons"].freeze
  CHECKPOINT = "Security Checkpoint".freeze

  def initialize(description)
    @description = description
  end

  def name
    @description.match(NAME_MATCHER)[:name]
  end

  def doors
    @description.scan(/^- (#{Regexp.union(DIRECTIONS)})$/).flatten
  end

  def items
    @description.scan(/^- (.+)$/).flatten.reject do |item|
      DIRECTIONS.include?(item) || TRAPS.include?(item)
    end
  end
end

class Droid
  # rubocop:disable Layout/LineLength
  PASSWORD_MATCHER = /You should be able to get in by typing (?<password>\d+) on the keypad at the main airlock\./.freeze
  # rubocop:enable Layout/LineLength
  OVERWEIGHT_MATCHER = /lighter/.freeze

  def initialize(intcode)
    @computer = Computer.new(intcode)
  end

  def password
    checkpoint, inventory = explore!

    checkpoint.each { |direction| run!(direction) }
    inventory.each { |item| run!("drop #{item}") }

    inventory = inventory.reject { |item| test_combination([item], checkpoint.last).match?(OVERWEIGHT_MATCHER) }

    (2..inventory.size).each do |size|
      inventory.combination(size).each do |items|
        description = test_combination(items, checkpoint.last)
        return description.match(PASSWORD_MATCHER)[:password] if description.match?(PASSWORD_MATCHER)
      end
    end
  end

  private

  def explore!
    queue = Hash.new { |h, k| h[k] = [] }
    path = []
    inventory = []
    checkpoint = nil

    room = Room.new(run!)
    queue[room.name] = room.doors

    loop do
      break if queue.values.all?(&:empty?) && path.empty?
      (room = Room.new(run!(reverse(path.pop)))) && next if queue[room.name].empty?

      direction = queue[room.name].shift
      room = Room.new(run!(direction))
      path.push(direction)

      inventory += room.items.each { |item| run!("take #{item}") }
      (checkpoint = path.dup) && next if room.name == Room::CHECKPOINT

      queue[room.name] = room.doors - [reverse(direction)]
    end

    [checkpoint, inventory]
  end

  def run!(command = "")
    @computer.run(inputs: "#{command}\n".chars.map(&:ord) + [10]).map(&:chr).join
  end

  def reverse(direction)
    Room::DIRECTIONS[(Room::DIRECTIONS.index(direction) + 2) % Room::DIRECTIONS.count]
  end

  def test_combination(items, direction)
    items.each { |item| run!("take #{item}") }
    description = run!(direction)
    items.each { |item| run!("drop #{item}") }

    description
  end
end

droid = Droid.new(INTCODE)
puts "The password for the main airlock is:", droid.password
