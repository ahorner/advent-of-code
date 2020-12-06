GRID = INPUT.split("\n").each_with_object({}).with_index do |(line, field), y|
  line.split("").each_with_index { |c, x| field[[x, y]] = (c == "#") }
end

class AsteroidField
  def initialize(field)
    @field = field.dup
  end

  def asteroids
    @field.keys.select { |coords| @field[coords] }
  end

  def visible_from(x, y)
    asteroids.select { |i, j| !(i == x && j == y) && line_of_sight?(x, y, i, j) }
  end

  def sweep_from!(x, y)
    sequence = []

    loop do
      targets = visible_from(x, y).sort_by { |i, j| angle_for(i - x, j - y) }
      targets.each { |i, j| @field[[i, j]] = false }
      sequence += targets

      break sequence if asteroids.count <= 1
    end
  end

  private

  def angle_for(dx, dy)
    Math.atan2(dx, -dy) % (Math::PI * 2)
  end

  def line_of_sight?(x, y, i, j)
    cx = x
    cy = y
    dx = i - x
    dy = j - y

    2.upto([dx.abs, dy.abs].max) do |n|
      while dx % n == 0 && dy % n == 0
        dx /= n
        dy /= n
      end
    end

    loop do
      cx += dx
      cy += dy
      break if cx == i && cy == j
      return false if @field[[cx, cy]]
    end

    true
  end
end

field = AsteroidField.new(GRID)
station = field.asteroids.max_by { |x, y| field.visible_from(x, y).count }

puts "The number of detectable asteroids from the station is:", field.visible_from(*station).count, "\n"

TARGET = 200
x, y = field.sweep_from!(*station)[TARGET - 1]

puts "The number of the 200th vaporized asteroid will be:", x * 100 + y
