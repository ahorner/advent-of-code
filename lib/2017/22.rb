class Network
  STAGES = %w[. #].freeze
  EVOLVED_STAGES = %w[. W # F].freeze

  attr_accessor :center

  def initialize(input, evolved: false)
    @evolved = evolved
    @nodes = Hash.new(".")

    rows = 0
    columns = 0

    input.split("\n").each_with_index do |line, y|
      rows = [rows, y].max
      line.chars.each_with_index do |c, x|
        columns = [columns, x].max
        @nodes[[x, y]] = c
      end
    end

    @center = [rows / 2, columns / 2]
  end

  def [](position)
    @nodes[position]
  end

  def advance!(position)
    stages = @evolved ? EVOLVED_STAGES : STAGES
    @nodes[position] = stages[(stages.index(@nodes[position]) + 1) % stages.size]
  end
end

class Carrier
  DIRECTIONS = %i[u r d l].freeze
  MOVES = {u: [0, -1], r: [1, 0], d: [0, 1], l: [-1, 0]}.freeze
  TURNS = {"." => -1, "W" => 0, "#" => 1, "F" => 2}.freeze

  attr_accessor :infections

  def initialize(network)
    @direction = :u
    @infections = 0

    @network = network
    @position = @network.center
  end

  def burst!
    turn!(TURNS[@network[@position]])

    result = @network.advance!(@position)
    @infections += 1 if result == "#"

    @position[0] += MOVES[@direction][0]
    @position[1] += MOVES[@direction][1]
  end

  def turn!(amount)
    @direction = DIRECTIONS[(DIRECTIONS.index(@direction) + amount) % DIRECTIONS.size]
  end
end

network = Network.new(INPUT)
carrier = Carrier.new(network)
10_000.times { carrier.burst! }

solve!("The number of infections caused by the carrier is:", carrier.infections)

network = Network.new(INPUT, evolved: true)
carrier = Carrier.new(network)
10_000_000.times { carrier.burst! }

solve!("The number of evolved infections caused by the carrier is:", carrier.infections)
