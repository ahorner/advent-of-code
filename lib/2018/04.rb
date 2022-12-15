MATCHER = /\A\[(?<year>\d+)-(?<month>\d+)-(?<date>\d+) (?<hour>\d+):(?<minute>\d+)\] (?<activity>.+)\z/
SHIFT_MATCHER = /Guard #(?<id>\d+) begins shift/

class Guard
  attr_reader :id

  def initialize(id)
    @id = id
    @status = Hash.new(0)
    @sleep = nil
  end

  def sleep!(minute)
    @start_time = minute
  end

  def wake!(minute)
    (@start_time...minute).each do |i|
      @status[i] += 1
    end

    @start_time = nil
  end

  def time_asleep
    @status.values.sum
  end

  def likeliest_nap
    @status.max_by { |(_, naps)| naps }.first
  end

  def max_naps
    return 0 unless @status.any?

    @status.values.max
  end
end

LOG = INPUT.split("\n").sort_by do |l|
  data = l.match(MATCHER)
  [data[:year].to_i, data[:month].to_i, data[:date].to_i, data[:hour].to_i, data[:minute].to_i]
end

guards = {}
current_guard = nil

LOG.each do |line|
  data = line.match(MATCHER)

  case data[:activity]
  when SHIFT_MATCHER
    guards[$~[:id]] ||= Guard.new($~[:id].to_i)
    current_guard = guards[$~[:id]]
  when "falls asleep"
    current_guard.sleep!(data[:minute].to_i)
  when "wakes up"
    current_guard.wake!(data[:minute].to_i)
  end
end

most_likely = guards.values.max_by(&:time_asleep)
solve!("Guard ##{most_likely.id} naps most often, at minute #{most_likely.likeliest_nap}:",
  most_likely.id * most_likely.likeliest_nap)

most_likely = guards.values.max_by(&:max_naps)
solve!("Guard ##{most_likely.id} naps most consistently, at minute #{most_likely.likeliest_nap}:",
  most_likely.id * most_likely.likeliest_nap)
