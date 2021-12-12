MAP = INPUT.split("\n").each_with_object(Hash.new { |h, k| h[k] = [] }) do |line, map|
  rooms = line.split("-")

  map[rooms[0]] << rooms[1]
  map[rooms[1]] << rooms[0]
end.freeze

class Path
  attr_reader :current

  def initialize(path = %w[start], revisit: false)
    @path = path
    @current = path.last
    @revisit = revisit
  end

  def visitable?(cave)
    return true unless small?(cave)
    return false if %w[start end].include?(cave) && @path.include?(cave)

    !@path.include?(cave) || @revisit
  end

  def visiting(cave)
    revisit = small?(cave) && @path.include?(cave) ? false : @revisit

    Path.new(@path + [cave], revisit: revisit)
  end

  private

  def small?(cave)
    cave.downcase == cave
  end
end

def paths(from:)
  current = from.current
  return [from] if current == "end"

  MAP[current].filter_map do |cave|
    next unless from.visitable?(cave)

    paths(from: from.visiting(cave))
  end.flatten(1)
end

solve!("The number of distinct paths from start to end is:", paths(from: Path.new).size)
solve!("The number of distinct paths from start to end (with a detour) is:", paths(from: Path.new(revisit: true)).size)
