require "delegate"

class Packet < SimpleDelegator
  include Comparable

  def <=>(other)
    (0...[size, other.size].max).each do |i|
      l = self[i]
      r = other[i]

      return -1 if l.nil?
      return 1 if r.nil?

      case [l.class, r.class]
      when [Integer, Integer]
        return -1 if l < r
        return 1 if l > r
      else
        result = Packet.new(Array(l)) <=> Packet.new(Array(r))
        return -1 if result < 0
        return 1 if result > 0
      end
    end

    0
  end
end

PAIRS = INPUT.split("\n\n").map do |pair|
  l, r = pair.split("\n").map(&method(:eval))
  [Packet.new(l), Packet.new(r)]
end

solve!(
  "The sum of ordered pair indices is:",
  PAIRS.each_with_index.sum { |(l, r), i| l < r ? i + 1 : 0 },
)

DIVIDERS = [Packet.new([[2]]), Packet.new([[6]])].freeze
PACKETS = (PAIRS.flatten(1) + DIVIDERS).sort

solve!(
  "The decoder key for the distress signal is:",
  DIVIDERS.map { |p| PACKETS.index(p) + 1 }.reduce(:*),
)
