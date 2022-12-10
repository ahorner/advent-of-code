SIGNALS = INPUT.split("\n").map(&:split).freeze

def run(cycles)
  x = 1
  cycle = 0

  loop do
    SIGNALS.each do |(instruction, value)|
      delay, dx = 
        case instruction
        when "noop" then [1, 0]
        when "addx" then [2, value.to_i]
        end

      delay.times do
        cycle += 1
        yield cycle, x, cycles.include?(cycle)
      end
      x += dx
    end

    break if cycle >= cycles.max
  end
end

total = 0
run([20, 60, 100, 140, 180, 220]) do |cycle, x, interesting|
  total += (x * cycle) if interesting
end

solve!(
  "The total signal strength from interesting cycles is:",
  total,
)

crt = ""
run([40, 80, 120, 160, 200, 240]) do |cycle, x, interesting|
  overlaps = (x - ((cycle - 1) % 40)).abs <= 1
  crt << (overlaps ? "#" : ".")
  crt << "\n" if interesting
end

solve!(
  "The message displayed on the CRT is as follows:",
  crt,
)
