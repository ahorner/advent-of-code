MATCHER = /depth: (?<depth>\d+)\ntarget: (?<x>\d+),(?<y>\d+)/

class Cave
  EROSION_MOD = 20183
  X_MULTIPLIER = 16807
  Y_MULTIPLIER = 48271

  def initialize(depth, target)
    @depth, @target = depth, target

    @geologic_indices = {}
    @erosion_levels = {}
    @risk_levels = {}
  end

  def geologic_index(region)
    @geologic_indices[region] ||=
      if region == [0, 0] || region == @target
        0
      elsif region[1] == 0
        region[0] * X_MULTIPLIER
      elsif region[0] == 0
        region[1] * Y_MULTIPLIER
      else
        erosion_level([region[0] - 1, region[1]]) *
          erosion_level([region[0], region[1] - 1])
      end
  end

  def erosion_level(region)
    @erosion_levels[region] ||= (geologic_index(region) + @depth) % EROSION_MOD
  end

  def risk_level(region)
    @risk_levels[region] ||= erosion_level(region) % 3
  end
end

data = INPUT.match(MATCHER)
TARGET = [data[:x].to_i, data[:y].to_i]
CAVE = Cave.new(data[:depth].to_i, TARGET)

total_risk = (0..data[:y].to_i).sum do |y|
  (0..data[:x].to_i).sum { |x|  CAVE.risk_level([x, y]) }
end

puts "The total risk level of the rectangle from 0,0 to the target is:", total_risk, nil

class PriorityQueue
  def initialize
    @list = []
  end

  def add(*item)
    @list << item
    @list.sort_by!(&:first)
  end

  def next
    @list.shift
  end

  def empty?
    @list.empty?
  end
end

EQUIPMENT = {
  neither: 0,
  torch: 1,
  gear: 2,
}.freeze

queue = PriorityQueue.new
queue.add(0, 0, 0, EQUIPMENT[:torch])
times = Hash.new(Float::INFINITY)

time = loop do
  break nil if queue.empty?

  minutes, x, y, equip = queue.next
  next if times[[x, y, equip]] <= minutes
  break minutes if [x, y, equip] == [*TARGET, EQUIPMENT[:torch]]

  times[[x, y, equip]] = minutes

  EQUIPMENT.values.each do |e|
    next if e == equip || e == CAVE.risk_level([x, y])
    next if times[[x, y, e]] <= minutes + 7

    queue.add(minutes + 7, x, y, e)
  end

  [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |dx, dy|
    nx, ny = x + dx, y + dy
    next if nx < 0 || nx > TARGET[0] * 4 || ny < 0 || ny > TARGET[1] * 4
    next if CAVE.risk_level([nx, ny]) == equip
    next if times[[nx, ny, equip]] <= minutes + 1

    queue.add(minutes + 1, nx, ny, equip)
  end
end

puts "The minimal time to find our friend is:", time