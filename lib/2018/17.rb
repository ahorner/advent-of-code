MATCHER = /(?<static>x|y)=(?<point>\d+), (?<range>x|y)=(?<min>\d+)..(?<max>\d+)/.freeze
CLAY = INPUT.split("\n").each_with_object(Hash.new(false)) do |line, clay|
  data = line.match(MATCHER)
  (data[:min].to_i..data[:max].to_i).each do |i|
    point = { data[:static].to_sym => data[:point].to_i, data[:range].to_sym => i }
    clay[[point[:x], point[:y]]] = true
  end
end

class Spring
  RESTING = "~".freeze
  FLOWING = "|".freeze

  attr_reader :water

  def initialize(clay)
    @clay = clay
    @miny, @maxy = clay.keys.map(&:last).minmax

    @water = {}
  end

  def flow!(x, y = @miny)
    @water[[x, y]] = FLOWING
    return if @water[[x, y + 1]]

    depth = y
    depth += 1 until depth == @maxy || rests?(x, depth)

    depth.downto(y) do |j|
      @water[[x, j]] = FLOWING
      fill!(x, j) if rests?(x, j)
    end
  end

  def fill!(x, y)
    left = x
    right = x
    left -= 1 until @clay[[left - 1, y]] || !rests?(left, y)
    right += 1 until @clay[[right + 1, y]] || !rests?(right, y)

    state = rests?(left, y) && rests?(right, y) ? RESTING : FLOWING
    (left..right).each { |i| @water[[i, y]] = state }
    [left, right].each { |i| flow!(i, y) unless rests?(i, y) }
  end

  private

  def rests?(x, y)
    @clay[[x, y + 1]] || @water[[x, y + 1]] == RESTING
  end
end

spring = Spring.new(CLAY)
spring.flow!(500)

puts "The water can reach the following number of spaces:", spring.water.count, nil
puts "The water will rest in the following number of spaces:", spring.water.values.count(Spring::RESTING)
