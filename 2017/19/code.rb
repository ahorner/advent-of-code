class Tube

  attr_reader :opening

  def initialize(input)
    @grid = {}
    @opening = nil

    input.split("\n").each_with_index do |row, y|
      row.split("").each_with_index do |cell, x|
        @grid[[x, y]] =
          if cell == " "
            false
          elsif cell =~ /\w/
            cell
          else
            true
          end

        @opening = [x, y] if @grid[[x, y]] && y == 0
      end
    end
  end

  def valid?(space)
    !!@grid[space]
  end

  def letter(space)
    @grid[space].is_a?(String) ? @grid[space] : nil
  end

end

class Packet

  DIRECTIONS = {
    up: [0, -1],
    down: [0, 1],
    left: [-1, 0],
    right: [1, 0],
  }

  attr_reader :collection, :steps

  def initialize(tube)
    @tube = tube
  end

  def navigate
    @position = @tube.opening
    @collection = []
    @steps = 0

    @direction = :down
    @last_position = nil

    loop do
      @steps += 1

      direction, move_to = next_move
      break if direction.nil?

      @direction = direction
      @last_position = @position
      @position = move_to

      letter = @tube.letter(@position)
      @collection << letter if letter
    end
  end

  private

  def next_move
    new_direction = ([@direction] + DIRECTIONS.keys).detect do |dir|
      new_position = move(dir)
      new_position != @last_position && @tube.valid?(new_position)
    end

    return [nil, nil] unless new_direction
    [new_direction, move(new_direction)]
  end

  def move(direction)
    [
      @position[0] + DIRECTIONS[direction][0],
      @position[1] + DIRECTIONS[direction][1],
    ]
  end

end

tube = Tube.new(INPUT)
packet = Packet.new(tube)
packet.navigate

puts "The packet collected letters in the order:", packet.collection.join, nil
puts "The number of steps the packet moved is:", packet.steps


