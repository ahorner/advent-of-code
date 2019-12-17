require_relative "../shared/intcode"
require "zlib"

class Navigator
  MOVES = { "^" => [0, -1], ">" => [1, 0], "v" => [0, 1], "<" => [-1, 0] }.freeze
  DIRECTIONS = MOVES.keys
  TURNS = { "L" => -1, "R" => 1 }.freeze

  def initialize(map)
    @map = map
  end

  def path
    path = []
    position, dir = @map.detect { |_, c| MOVES.key?(c) }
    x, y = position

    loop do
      i, j = MOVES[dir]

      if @map[[x + i, y + j]] != "#"
        turn = TURNS.keys.detect do |t|
          m, n = MOVES[turn_to(dir, t)]
          @map[[x + m, y + n]] == "#"
        end

        break unless turn

        path << turn
        dir = turn_to(dir, turn)
      else
        count = 0
        x, y, count = x + i, y + j, count + 1 while @map[[x + i, y + j]] == "#"
        path << count
      end
    end

    path.join(",")
  end

  private

  def turn_to(direction, turn)
    current = DIRECTIONS.index(direction)
    DIRECTIONS[(current + TURNS[turn]) % DIRECTIONS.count]
  end
end

class PathCompressor
  FUNCTIONS = ["A", "B", "C"].freeze
  MEMORY_LIMIT = 20

  def initialize(path)
    @path = path
  end

  def main_routine
    FUNCTIONS.zip(functions).reduce(@path) { |routine, (f, function)| routine.gsub(function, f) }
  end

  def functions(path = @path, current = [])
    return current if path.empty?
    return nil if current.length >= FUNCTIONS.length

    candidates = (1..MEMORY_LIMIT).map { |i| normalize(path[0..i]) }.uniq
    candidates.detect do |candidate|
      new_path = normalize(path.gsub(candidate, ""))
      final = functions(new_path, current + [candidate])
      break final if final
    end
  end

  private

  def normalize(path)
    path.sub(/^\,+/, "").sub(/\,+$/, "")
  end
end

x, y = 0, 0

map = Computer.new(INTCODE).run.each_with_object({}) do |tile, map|
  if tile == 10
    x, y = 0, y + 1
    next
  else
    map[[x, y]] = tile.chr
    x += 1
  end
end

intersections = map.select { |(x, y), tile| tile == "#" && Navigator::MOVES.all? { |_, (i, j)| map[[x + i, y + j]] == "#" } }
puts "The sum of alignment parameters is:", intersections.sum { |(i, j), _| i * j }, "\n"

path = Navigator.new(map).path
compressor = PathCompressor.new(path)
instructions = [compressor.main_routine, *compressor.functions, "n"]

wakeup = INTCODE.dup.tap { |program| program[0] = 2 }
vacuum = Computer.new(wakeup)
output = instructions.flat_map { |line| vacuum.run(inputs: line.chars.map(&:ord) + [10]) }

puts "The amount of dust collected is:", output.last
