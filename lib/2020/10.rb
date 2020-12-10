ADAPTERS = INPUT.split("\n").map(&:to_i).sort

MAX_RANGE = 3
CHARGER_RATING = 0
DEVICE_RATING = ADAPTERS.last + MAX_RANGE
CHAIN = [CHARGER_RATING] + ADAPTERS + [DEVICE_RATING]

differences = Hash.new(0)
CHAIN.each_cons(2) do |first, second|
  differences[second - first] += 1
end

solve!("The product of 1-jolt and 3-jolt ranges is:", differences[1] * differences[3])

options = Hash.new(0)
options[CHARGER_RATING] = 1

CHAIN.drop(1).each do |adapter|
  options[adapter] = (1..MAX_RANGE).sum { |i| options[adapter - i] }
end

solve!("The number of valid arrangements is:", options[DEVICE_RATING])
