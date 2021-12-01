require_relative "./shared/intcode"

class Beam
  def initialize(program)
    @program = program
  end

  def pulls?(x, y)
    Computer.new(@program).run(inputs: [x, y]).last == 1
  end

  def fit_point(size)
    offset = size - 1
    x = 0
    y = size + 1

    loop do
      x += 1 until pulls?(x, y)
      break [x, y - offset] if pulls?(x + offset, y - offset)

      y += 1
    end
  end
end

beam = Beam.new(INTCODE)

grid = {}
50.times { |y| 50.times { |x| grid[[x, y]] = beam.pulls?(x, y) } }
solve!("The number of beam points in a 50x50 grid is:", grid.count(&:last))

x, y = beam.fit_point(100)
solve!("The best 100x100 is:", (x * 10_000) + y)
