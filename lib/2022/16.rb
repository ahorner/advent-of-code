require "rb_heap"
require "set"

class Valve
  MATCHER = /Valve (?<id>[A-Z]+) has flow rate=(?<flow>\d+); tunnels? leads? to valves? (?<connections>[A-Z, ]+)/

  attr_reader :id, :flow, :connections

  def initialize(description)
    data = MATCHER.match(description)
    @id = data[:id]
    @flow = data[:flow].to_i
    @connections = data[:connections].split(", ")
  end
end

VALVES = INPUT.split("\n").to_h do |line|
  valve = Valve.new(line)
  [valve.id, valve]
end

class Volcano
  def initialize(valves)
    @valves = valves
  end

  def tunnels
    return @tunnels if @tunnels

    queue = Heap.new { |a, b| a[0] < b[0] }
    distances = Hash.new { |h, k| h[k] = Hash.new(Float::INFINITY) }

    @valves.each do |id, valve|
      valve.connections.each do |conn|
        distances[id][id] = 0
        distances[id][conn] = 1
        queue << [1, @valves[conn], [id, conn]]
      end
    end

    @valves.each_key do |midpoint|
      @valves.each_key do |origin|
        @valves.each_key do |destination|
          distance = distances[origin][midpoint] + distances[midpoint][destination]
          distances[origin][destination] = distance if distances[origin][destination] > distance
        end
      end
    end

    @tunnels = distances
  end

  def best_pressure(time:, workers: 1)
    queue = Heap.new { |a, b| a[0] > b[0] }
    states = {}

    team = workers.times.to_h { |i| [i, ["AA", time]] }
    queue << [0, team, Set.new]

    loop do
      break if queue.empty?

      pressure, team, opened = queue.pop

      team.each do |id, (room, remaining)|
        tunnels[room].each do |valve, distance|
          next if opened.include?(valve)
          next if @valves[valve].flow == 0

          new_remaining = remaining - distance - 1
          next if new_remaining <= 0

          new_pressure = pressure + @valves[valve].flow * new_remaining
          new_opened = opened + [valve]
          new_team = team.merge(id => [valve, new_remaining])

          rooms = new_team.values.map(&:first).sort

          state = [rooms, new_opened].hash
          next if states.key?(state) && states[state] >= new_pressure

          states[state] = new_pressure
          queue << [new_pressure, new_team, new_opened]
        end
      end
    end

    states.values.max
  end
end

volcano = Volcano.new(VALVES)

solve!(
  "The maximum pressure release after 30 minutes is:",
  volcano.best_pressure(time: 30)
)
solve!(
  "The maximum pressure release with a helper elephant is:",
  volcano.best_pressure(workers: 2, time: 26)
)
