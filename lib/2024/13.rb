require "matrix"

BUTTON_MATCHER = /\AButton (?<button>A|B): X\+(?<x>[0-9]+), Y\+(?<y>[0-9]+)\z/
PRIZE_MATCHER = /\APrize: X=(?<x>[0-9]+), Y=(?<y>[0-9]+)\z/

MACHINES = INPUT.split("\n\n").map do |machine|
  a, b, prize = machine.split("\n")

  a = a.match(BUTTON_MATCHER)
  b = b.match(BUTTON_MATCHER)
  prize = prize.match(PRIZE_MATCHER)

  {
    a: Vector[a[:x].to_i, a[:y].to_i],
    b: Vector[b[:x].to_i, b[:y].to_i],
    prize: Vector[prize[:x].to_i, prize[:y].to_i]
  }
end

def win(machine, offset: 0)
  target = machine[:prize] + Vector[offset, offset]

  d = machine[:a][0] * machine[:b][1] - machine[:a][1] * machine[:b][0]
  return 0 if d == 0

  da = machine[:b][1] * target[0] - machine[:b][0] * target[1]
  db = machine[:a][0] * target[1] - machine[:a][1] * target[0]

  return da / d * 3 + db / d if da % d == 0 && db % d == 0

  0
end

solve!(
  "The minimum number of tokens to acquire all prizes is:",
  MACHINES.sum { |machine| win(machine) }
)

solve!(
  "The minimum number of tokens to acquire all (distant) prizes is:",
  MACHINES.sum { |machine| win(machine, offset: 10_000_000_000_000) }
)
