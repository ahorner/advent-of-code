timestamp, bus_ids = INPUT.split("\n")

TIMESTAMP = timestamp.to_i
BUS_IDS = bus_ids.split(",").map { |id| id == "x" ? nil : id.to_i }.freeze

def wait_for(bus_ids, timestamp)
  loop do
    bus = bus_ids.compact.detect { |id| timestamp % id == 0 }
    break bus, timestamp if bus

    timestamp += 1
  end
end

bus, at = wait_for(BUS_IDS, TIMESTAMP)
solve!("The next bus's combined ID and wait time is:", bus * (at - TIMESTAMP))

# No clever coding here. Just shoehorning in an implementation of a mathematical
# theorem that I definitely had to look up.
class ScheduleSolver
  def initialize(ids)
    @ids = ids
  end

  def timestamp
    remainders = @ids.map.with_index { |id, n| id ? -n % id : nil }
    chinese_remainder(@ids.compact, remainders.compact)
  end

  private

  # Apologies to https://rosettacode.org/wiki/Chinese_remainder_theorem#Ruby
  def chinese_remainder(moduli, remainders)
    max = moduli.inject(:*)

    series = remainders.zip(moduli).map do |remainder, modulus|
      remainder * max / modulus * modular_inverse(max / modulus, modulus)
    end

    series.inject(:+) % max
  end

  def modular_inverse(e, et)
    gcd, = extended_gcd(e, et)
    gcd % et
  end

  # Apologies to https://gist.github.com/gpfeiffer/4013925
  def extended_gcd(a, b)
    return 1, 0 if b == 0

    quotient, remainder = a.divmod(b)
    s, t = extended_gcd(b, remainder)

    [t, s - (quotient * t)]
  end
end

solver = ScheduleSolver.new(BUS_IDS)
solve!("The first timestamp for offset departures is:", solver.timestamp)
