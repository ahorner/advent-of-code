DIRECTIONS = {
  n: [0, -1],
  e: [1, 0],
  s: [0, 1],
  w: [-1, 0]
}.freeze

Beam = Data.define(:direction) do
  def move((x, y))
    dx, dy = DIRECTIONS[direction]
    [x + dx, y + dy]
  end

  def bounce(mirror)
    case [direction, mirror]
    when [:n, "/"], [:s, "\\"] then [Beam.new(:e)]
    when [:n, "\\"], [:s, "/"] then [Beam.new(:w)]
    when [:n, "-"], [:s, "-"] then [Beam.new(:e), Beam.new(:w)]
    when [:e, "/"], [:w, "\\"] then [Beam.new(:n)]
    when [:e, "\\"], [:w, "/"] then [Beam.new(:s)]
    when [:e, "|"], [:w, "|"] then [Beam.new(:n), Beam.new(:s)]
    else
      [self]
    end
  end
end

CONTRAPTION = INPUT.split("\n").each_with_index.each_with_object({}) do |(line, y), contraption|
  line.chars.each_with_index do |c, x|
    contraption[[x, y]] = c
  end
end

def energy_for(contraption, tile: [-1, 0], beam: Beam.new(:e))
  width = contraption.keys.map(&:first).max
  height = contraption.keys.map(&:last).max

  energized = {}
  seen = {}

  beams = [[tile, beam]]

  loop do
    break if beams.empty?

    position, beam = beams.shift
    next if seen[[position, beam]]

    seen[[position, beam]] = true
    x, y = beam.move(position)

    next if x < 0 || y < 0 || x > width || y > height

    energized[[x, y]] = true
    beams += beam.bounce(contraption[[x, y]]).map { |b| [[x, y], b] }
  end

  energized.count
end

solve!("The number of energized tiles is:", energy_for(CONTRAPTION))

def most_energy(contraption)
  width = contraption.keys.map(&:first).max
  height = contraption.keys.map(&:last).max

  north = (0..width).map { |x| energy_for(contraption, tile: [x, height + 1], beam: Beam.new(:n)) }
  east = (0..height).map { |y| energy_for(contraption, tile: [-1, y], beam: Beam.new(:e)) }
  south = (0..width).map { |x| energy_for(contraption, tile: [x, -1], beam: Beam.new(:s)) }
  west = (0..height).map { |y| energy_for(contraption, tile: [width + 1, y], beam: Beam.new(:w)) }

  [north.max, east.max, south.max, west.max].max
end

solve!("The maximum number of energized tiles is:", most_energy(CONTRAPTION))
