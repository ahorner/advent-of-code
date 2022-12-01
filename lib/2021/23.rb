require "rb_heap/heap"

class Amphipod
  COSTS = { A: 1, B: 10, C: 100, D: 1_000 }.freeze
  ROOMS = { A: 0, B: 1, C: 2, D: 3 }.freeze

  attr_reader :type

  def initialize(type)
    @type = type.to_sym
  end

  def cost
    COSTS[@type]
  end

  def target
    ROOMS[@type]
  end
end

class Burrow
  ROOM_COORDS = [2, 4, 6, 8].freeze

  attr_reader :rooms, :hallway

  def initialize(rooms, hallway = Array.new(11))
    @rooms = rooms
    @hallway = hallway
  end

  def solved?
    rooms.each_with_index.all? { |room, i| room.all? { |amphipod| amphipod&.target == i } }
  end

  def enter(hall:, room:)
    a = hallway[hall]
    return if a.nil?

    r = rooms[room]
    return if r.any? { |x| !x.nil? && x.type != a.type }
    return unless possible?(hall: hall, room: room)

    cost = energy_needed(hall: hall, room: room)

    i = r.count(&:nil?) - 1

    new_rooms = rooms.map(&:dup)
    new_hallway = hallway.dup

    new_rooms[room][i] = a
    new_hallway[hall] = nil

    enter_cost = i + 1

    [(cost + enter_cost) * a.cost, Burrow.new(new_rooms, new_hallway)]
  end

  def leave(hall:, room:)
    return unless hallway[hall].nil?
    return unless possible?(hall: hall, room: room)

    r = rooms[room]
    return if r.all?(&:nil?)

    cost = energy_needed(hall: hall, room: room)

    a, i = r.each_with_index.detect { |a, _| !a.nil? }
    return if a.nil?
    return if a.target == room && r.all? { |x| x.nil? || x.type == a.type }

    new_rooms = rooms.map(&:dup)
    new_hallway = hallway.dup

    new_hallway[hall] = a
    new_rooms[room][i] = nil

    leave_cost = i + 1

    [(cost + leave_cost) * a.cost, Burrow.new(new_rooms, new_hallway)]
  end

  def eql?(other)
    hash == other.hash
  end

  def hash
    [hallway, rooms].hash
  end

  private

  def energy_needed(hall:, room:)
    (ROOM_COORDS[room] - hall).abs
  end

  def possible?(hall:, room:)
    room = ROOM_COORDS[room]
    left = hall <= room
    range = left ? (hall + 1)..(room - 1) : (room + 1)..(hall - 1)

    hallway[range].all?(&:nil?)
  end
end

def organize(rooms)
  burrow = Burrow.new(rooms)

  queue = Heap.new { |a, b| a[0] < b[0] }
  queue << [0, burrow, [burrow]]

  costs = {}
  costs[burrow] = 0

  loop do
    energy, burrow = queue.pop
    break energy if burrow.solved?

    next if energy > costs[burrow]

    costs[burrow] = energy

    burrow.hallway.each_with_index do |a, i|
      next if Burrow::ROOM_COORDS.include?(i)

      if a.nil?
        exits = burrow.rooms.each_index.filter_map { |j| burrow.leave(hall: i, room: j) }
        exits.each do |exit_cost, exit_burrow|
          cost = energy + exit_cost
          next if costs.key?(exit_burrow) && cost >= costs[exit_burrow]

          costs[exit_burrow] = cost
          queue << [cost, exit_burrow]
        end
      else
        entry = burrow.enter(hall: i, room: a.target)
        next if entry.nil?

        entry_cost, entry_burrow = entry
        cost = energy + entry_cost
        next if costs.key?(entry_burrow) && cost >= costs[entry_burrow]

        costs[entry_burrow] = cost
        queue << [cost, entry_burrow]
      end
    end
  end
end

ROOMS = INPUT.scan(/\w/).each_slice(4).each_with_object(Array.new(4) { [] }) do |types, rooms|
  types.each_with_index { |t, i| rooms[i] << Amphipod.new(t) }
end

energy = organize(ROOMS)
solve!("The minimum energy to organize the amphipods is:", energy)

INSERTIONS = [%w[D D], %w[C B], %w[B A], %w[A C]].freeze
UPDATED_ROOMS = ROOMS.map.with_index do |r, i|
  r.dup.insert(1, *INSERTIONS[i].map { |c| Amphipod.new(c) })
end.freeze

energy = organize(UPDATED_ROOMS)
solve!("The minimum energy to organize the full set of amphipods is:", energy)
