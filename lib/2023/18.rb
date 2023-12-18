require "matrix"

DIRECTIONS = {
  U: Vector[0, -1],
  R: Vector[1, 0],
  D: Vector[0, 1],
  L: Vector[-1, 0]
}.freeze

CODES = %i[R D L U].freeze

Dig = Data.define(:direction, :meters, :code) do
  def path
    DIRECTIONS[direction] * meters
  end

  def coded_path
    hex = code.tr("(#)", "")
    meters = hex[0..4].to_i(16)

    DIRECTIONS[CODES[hex[5].to_i]] * meters
  end
end

class Lagoon
  def initialize(trench)
    @trench = trench
  end

  def area
    interior = 0
    boundary = 0

    @trench.each_cons(2) do |p, q|
      x, y = p.to_a
      i, j = q.to_a

      interior += x * j - i * y
      boundary += (p - q).magnitude
    end

    (interior.abs / 2 + boundary / 2 + 1).to_i
  end
end

DIG_PLAN = INPUT.split("\n").map do |line|
  direction, meters, code = line.split(" ")
  Dig.new(direction: direction.to_sym, meters: meters.to_i, code:)
end

def trench_for(plan, use: :path)
  position = Vector[0, 0]
  [position] + plan.map { |plan| position += plan.public_send(use) }
end

lagoon = Lagoon.new(trench_for(DIG_PLAN))
solve!("The total capacity of the lagoon is:", lagoon.area)

lagoon = Lagoon.new(trench_for(DIG_PLAN, use: :coded_path))
solve!("The total capacity of the lagoon (using the coded plan) is:", lagoon.area)
