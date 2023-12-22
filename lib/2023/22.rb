require "matrix"

Brick = Data.define(:starts, :ends) do |top|
  def height
    (ends[2] - starts[2]).abs + 1
  end

  def overlaps?(brick)
    brick.xrange.overlap?(xrange) && brick.yrange.overlap?(yrange)
  end

  def xrange
    x1, x2 = [starts[0], ends[0]].minmax
    x1..x2
  end

  def yrange
    y1, y2 = [starts[1], ends[1]].minmax
    y1..y2
  end
end

BRICKS = INPUT.split("\n").map do |line|
  starts, ends = line.split("~").map { |coords| Vector[*coords.split(",").map(&:to_i)] }
  Brick.new(starts:, ends:)
end

fall_sequence = BRICKS.sort_by { |b| [b.starts[2], b.ends[2]].min }

STACK = fall_sequence.each_with_object(Hash.new { |h, k| h[k] = [] }) do |brick, stack|
  stop =
    if stack.empty?
      0
    else
      stack.keys.max.downto(0).detect do |z|
        stack[z].any? { |b| b.overlaps?(brick) }
      end || 0
    end

  ((stop + 1)..(stop + brick.height)).each do |z|
    stack[z] << brick
  end
end

SUPPORTS = BRICKS.each_with_object(Hash.new { |h, k| h[k] = {below: [], above: []} }) do |brick, supports|
  z = STACK.keys.select { |k| STACK[k].include?(brick) }.max
  STACK[z + 1].each do |b|
    next unless b.overlaps?(brick)

    supports[b][:above] << brick
    supports[brick][:below] << b
  end
end

def supported(brick, supports, without: [])
  supports[brick][:below].select { |s| (supports[s][:above] - [brick] - without).empty? }
end

disintegratable = BRICKS.count { |brick| supported(brick, SUPPORTS).empty? }
solve!("The number of disintegratable bricks is:", disintegratable)

def falls_for(brick, supports)
  supporting = supported(brick, supports)
  return 0 if supporting.empty?

  fallen = supporting
  layer = supporting

  loop do
    break fallen.count if layer.empty?

    layer = layer.flat_map { |b| supported(b, supports, without: fallen) }.uniq
    fallen += layer
  end
end

solve!("The sum of potential falling bricks is:", BRICKS.sum { |brick| falls_for(brick, SUPPORTS) })
