class Screen
  attr_reader :pixels

  def initialize(width, height)
    @pixels = Hash.new(false)
    @width = width
    @height = height
  end

  def rect(width, height)
    height.times do |y|
      width.times { |x| @pixels[[y, x]] = true }
    end
  end

  def rotate(type, index, shift)
    size, key =
      case type
      when "row" then [@width, ->(i) { [index, i] }]
      when "column" then [@height, ->(i) { [i, index] }]
      end

    current = size.times.map { |i| @pixels[key.call(i)] }
    shifted = current.rotate(-shift)
    shifted.each_with_index { |value, i| @pixels[key.call(i)] = value }
  end

  def render
    @height.times.map do |y|
      @width.times.map { |x| (@pixels[[y, x]] ? "#" : ".") }.join
    end.join("\n")
  end
end

RECT_PATTERN = /rect (?<width>[0-9]+)x(?<height>[0-9]+)/
ROTATE_PATTERN = /rotate (?<type>\w*) .=(?<index>[0-9]+) by (?<shift>[0-9]+)/

SCREEN_DIMENSIONS ||= [50, 6].freeze
screen = Screen.new(*SCREEN_DIMENSIONS)

INPUT.split("\n").each do |line|
  case line
  when RECT_PATTERN
    matches = line.match(RECT_PATTERN)
    screen.rect(matches[:width].to_i, matches[:height].to_i)
  when ROTATE_PATTERN
    matches = line.match(ROTATE_PATTERN)
    screen.rotate(matches[:type], matches[:index].to_i, matches[:shift].to_i)
  end
end

solve!("The number of lit pixels is:", screen.pixels.count { |_, v| v })
solve!("You can read the screen below:\n\n", screen.render)
