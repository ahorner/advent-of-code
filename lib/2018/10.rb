MATCHER = /position=<(?<x>\s*-?\d+),(?<y>\s*-?\d+)> velocity=<(?<dx>\s*-?\d+),(?<dy>\s*-?\d+)>/.freeze

class Photon
  attr_reader :x, :y

  def initialize(x, y, dx, dy)
    @x = x
    @y = y
    @dx = dx
    @dy = dy
  end

  def position
    [@x, @y]
  end

  def tick!
    @x += @dx
    @y += @dy
  end

  def untick!
    @x -= @dx
    @y -= @dy
  end
end

def area(photons)
  minx, maxx = photons.map(&:x).minmax
  miny, maxy = photons.map(&:y).minmax

  (maxx - minx) * (maxy - miny)
end

def render(photons)
  map = Hash.new(".")
  photons.each { |p| map[p.position] = "#" }

  minx, maxx = photons.map(&:x).minmax
  miny, maxy = photons.map(&:y).minmax

  (miny..maxy).each_with_object("") do |y, output|
    (minx..maxx).each { |x| output << map[[x, y]] }
    output << "\n"
  end
end

photons = INPUT.split("\n").map do |line|
  data = line.match(MATCHER)
  Photon.new(data[:x].to_i, data[:y].to_i, data[:dx].to_i, data[:dy].to_i)
end

best = area(photons)
time = 0

loop do
  photons.each(&:tick!)

  score = area(photons)
  break photons.each(&:untick!) if score > best

  time += 1
  best = score
end

puts "The message (at time #{time}) is:", nil, render(photons)
