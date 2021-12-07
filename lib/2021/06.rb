LANTERNFISH = INPUT.split(",").map(&:to_i).freeze

MATURATION_DAYS = 2
GESTATION_DAYS = 7
CYCLE_DAYS = MATURATION_DAYS + GESTATION_DAYS

def next_state(timers)
  fish = (0...CYCLE_DAYS).map { |i| timers[i + 1].to_i }

  fish[CYCLE_DAYS - 1] += timers[0]
  fish[GESTATION_DAYS - 1] += timers[0]

  fish
end

def fish_after(days)
  fish = (0...CYCLE_DAYS).map { |i| LANTERNFISH.count(i) }
  days.times { fish = next_state(fish) }

  fish.sum
end

solve!("The number of lanternfish after 80 days is:", fish_after(80))
solve!("The number of lanternfish after 256 days is:", fish_after(256))
