require "set"

MATCHER = /\#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<width>\d+)x(?<height>\d+)/.freeze

Range.class_eval do
  def overlaps?(other)
    cover?(other.first) || other.cover?(first)
  end

  def intersection(other)
    return nil if max < other.begin || other.max < self.begin

    [self.begin, other.begin].max..[max, other.max].min
  end
  alias_method :&, :intersection
end

class Claim
  attr_reader :id

  def initialize(id:, x:, y:, width:, height:)
    @id = id
    @x = x
    @y = y
    @width = width
    @height = height
  end

  def horizontal
    @horizontal ||= @x..(@x + @width - 1)
  end

  def vertical
    @vertical ||= @y..(@y + @height - 1)
  end

  def overlap_with(other)
    return [] unless horizontal.overlaps?(other.horizontal) && vertical.overlaps?(other.vertical)

    [*(horizontal & other.horizontal)].product([*(vertical & other.vertical)])
  end
end

claims = INPUT.split("\n").map do |line|
  matches = line.match(MATCHER)

  Claim.new(
    id: matches[:id],
    x: matches[:x].to_i,
    y: matches[:y].to_i,
    width: matches[:width].to_i,
    height: matches[:height].to_i,
  )
end

overlaps = Set.new
overlapping = Set.new

claims.combination(2) do |(first, second)|
  overlap = first.overlap_with(second)
  next unless overlap.any?

  overlaps.merge(first.overlap_with(second))
  overlapping << first
  overlapping << second
end

puts "The number of overlapping inches is:", overlaps.size, nil

claim = claims.detect { |c| !overlapping.include?(c) }
puts "The only non-overlapping claim is:", claim.id
