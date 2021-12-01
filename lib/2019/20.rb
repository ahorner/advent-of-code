MAZE = INPUT.split("\n").each_with_index.each_with_object({}) do |(line, y), maze|
  line.chars.each_with_index { |cell, x| maze[[x, y]] = cell }
end

class Donut
  DIRECTIONS = [[0, -1, 0], [0, 1, 0], [-1, 0, 0], [1, 0, 0]].freeze
  PATH = ".".freeze

  def initialize(map, recursive: false)
    @map = map
    @recursive = recursive
  end

  def entrance
    [*portals["AA"][0], 0]
  end

  def exit
    [*portals["ZZ"][0], 0]
  end

  def path?(coords)
    @map[coords] == PATH
  end

  def estimator(target)
    if @recursive
      proc { |(x, y, z)| (target[0] - x).abs + (target[1] - y).abs + ((target[2] - z).abs**3) }
    else
      proc { 0 }
    end
  end

  def adjacent_coords((x, y, z))
    adjacent = DIRECTIONS.map { |i, j, k| [x + i, y + j, z + k] }.select { |i, j, _| path?([i, j]) }
    return adjacent unless warps.key?([x, y])

    i, j, depth = warps[[x, y]]
    return adjacent if depth < 0 && z == 0

    adjacent + [[i, j, z + depth]]
  end

  private

  def warps
    @warps ||= begin
      walls = @map.select { |_, c| c == "#" }
      outerx = walls.map { |coords, _| coords[0] }.minmax
      outery = walls.map { |coords, _| coords[1] }.minmax

      portals.each_with_object({}) do |(_, portals), warps|
        next if portals.length < 2

        outer, inner = portals.partition do |portal|
          outerx.include?(portal[0]) || outery.include?(portal[1])
        end.map(&:first)

        warps[inner] = [*outer, @recursive ? 1 : 0]
        warps[outer] = [*inner, @recursive ? -1 : 0]
      end
    end
  end

  def portals
    @portals ||= @map.each_with_object(Hash.new { |h, k| h[k] = [] }) do |((x, y), cell), portals|
      next unless cell =~ /[[:alpha:]]/

      if @map[[x + 1, y]] == PATH
        portals[@map[[x - 1, y]] + cell] << [x + 1, y]
      elsif @map[[x - 1, y]] == PATH
        portals[cell + @map[[x + 1, y]]] << [x - 1, y]
      elsif @map[[x, y - 1]] == PATH
        portals[cell + @map[[x, y + 1]]] << [x, y - 1]
      elsif @map[[x, y + 1]] == PATH
        portals[@map[[x, y - 1]] + cell] << [x, y + 1]
      end
    end
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
    traverse(start, estimator: @map.estimator(target)) do |spot, path|
      return path if spot == target
    end
  end

  private

  def traverse(start, estimator:)
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

donut = Donut.new(MAZE)
pathfinder = Pathfinder.new(donut)
path = pathfinder.path(donut.entrance, donut.exit)

solve!("The minimum path length between portals AA and ZZ is:", path.length)

donut = Donut.new(MAZE, recursive: true)
pathfinder = Pathfinder.new(donut)
path = pathfinder.path(donut.entrance, donut.exit)

solve!("The minimum recursive path length between portals AA and ZZ is:", path.length)
