require "matrix"

class Board
  MOVEMENT = {
    right: Vector[1, 0],
    down: Vector[0, 1],
    left: Vector[-1, 0],
    up: Vector[0, -1]
  }
  DIRECTIONS = MOVEMENT.keys

  attr_reader :map, :width, :height

  def initialize(diagram)
    @map = diagram.split("\n").each_with_index.each_with_object({}) do |(row, y), map|
      row.chars.each_with_index do |tile, x|
        next if tile == " "
        map[Vector[x + 1, y + 1]] = tile == "."
      end
    end

    @width = @map.keys.map { |p| p[0] }.max
    @height = @map.keys.map { |p| p[1] }.max
  end

  def move(position, facing, steps)
    steps.times do
      test = position + MOVEMENT[facing]
      direction = facing

      test, direction = wrap_to(position, facing) unless @map.key?(test)

      if @map[test]
        position = test
        facing = direction
      else
        break [position, facing]
      end
    end

    [position, facing]
  end

  def wrap_to(position, facing)
    search_from =
      case facing
      when :right then Vector[1, position[1]]
      when :down then Vector[position[0], 1]
      when :left then Vector[width, position[1]]
      when :up then Vector[position[0], height]
      end

    loop do
      break [search_from, facing] if map.key?(search_from)
      search_from += MOVEMENT[facing]
    end
  end

  def start
    wrap_to(Vector[width, 1], :right)
  end
end

class Cube < Board
  MOVEMENT = {
    right: Vector[1, 0, 0],
    down: Vector[0, 1, 0],
    left: Vector[-1, 0, 0],
    up: Vector[0, -1, 0]
  }

  Orientation = Struct.new(:u, :v, :w)

  def initialize(diagram, size)
    super(diagram)
    @size = size
  end

  def regions
    @regions ||= (1...height).step(CUBE_SIZE).each_with_object({}) do |row, regions|
      (1...width).step(CUBE_SIZE).each do |column|
        corner = Vector[column, row]
        next unless map.key?(corner)

        regions[corner] = region_vector(corner)
      end
    end
  end

  def faces
    return @faces if defined?(@faces)

    @faces = {}

    corner = regions.keys.first
    @faces[corner] = Orientation.new(Vector[1, 0, 0], Vector[0, 1, 0], Vector[0, 0, 1])

    queue = [[corner, @faces[corner]]]

    loop do
      break @faces if queue.empty?

      corner, face = queue.pop
      neighbors(corner).each do |neighbor, adjacency|
        next if @faces.key?(neighbor)

        @faces[neighbor] = Orientation.new(
          *case adjacency
           when :right then [-face.w, face.v, face.u]
           when :down then [face.u, -face.w, face.v]
           when :left then [face.w, face.v, -face.u]
           when :up then [face.u, face.w, -face.v]
           end
        )

        queue << [neighbor, @faces[neighbor]]
      end
    end
  end

  def start
    [regions.keys.first, :right]
  end

  private

  def wrap_to(position, facing)
    corner = regions.key(region_vector(position))
    face = faces[corner]

    adjacent = faces.values.find { |test| direction_to(face, test) == facing }
    reflection = direction_to(adjacent, face)

    normalized = position - faces.key(face)
    mapped =
      case [facing, reflection]
      when [:right, :right], [:down, :up], [:left, :left], [:up, :down]
        Vector[normalized[0], @size - 1 - normalized[1]]
      when [:right, :down], [:down, :right], [:left, :up], [:up, :left]
        Vector[normalized[1], normalized[0]]
      when [:right, :left], [:left, :right]
        normalized
      when [:right, :up], [:down, :left], [:left, :down], [:up, :right]
        Vector[@size - 1 - normalized[1], @size - 1 - normalized[0]]
      when [:down, :down], [:up, :up]
        Vector[@size - 1 - normalized[0], normalized[1]]
      end

    [mapped + faces.key(adjacent), DIRECTIONS[(DIRECTIONS.index(reflection) + 2) % DIRECTIONS.size]]
  end

  def direction_to(from, to)
    case to.w
    when from.u then :right
    when from.v then :down
    when -from.u then :left
    when -from.v then :up
    end
  end

  def region_vector(position)
    Vector[(position[0] - 1) / @size, (position[1] - 1) / @size]
  end

  def neighbors(corner)
    [
      [Vector[corner[0] + @size, corner[1]], :right],
      [Vector[corner[0], corner[1] + @size], :down],
      [Vector[corner[0] - @size, corner[1]], :left],
      [Vector[corner[0], corner[1] - @size], :up]
    ].select { |c, _| regions.key?(c) }
  end
end

def travel(board)
  position, facing = board.start

  INSTRUCTIONS.scan(/[0-9]+|L|R/) do |token|
    case token
    when "L", "R"
      turn = (token == "L") ? -1 : 1
      index = (Board::DIRECTIONS.index(facing) + turn) % Board::DIRECTIONS.size
      facing = Board::DIRECTIONS[index]
    else
      position, facing = board.move(position, facing, token.to_i)
    end
  end

  [position, facing]
end

def score_for(position, facing)
  1000 * position[1] + 4 * position[0] + Board::DIRECTIONS.index(facing)
end

MAP, INSTRUCTIONS = INPUT.split("\n\n")
BOARD = Board.new(MAP)

solve!(
  "The final password on a simple board is:",
  score_for(*travel(BOARD))
)

CUBE_SIZE ||= 50
CUBE = Cube.new(MAP, CUBE_SIZE)

solve!(
  "The final password on a folded cube is:",
  score_for(*travel(CUBE))
)
