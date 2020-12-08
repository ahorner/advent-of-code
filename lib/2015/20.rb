require "prime"

GIFTS = INPUT.to_i

def elves_for(house)
  # Apologies to: http://stackoverflow.com/questions/3398159/all-factors-of-a-given-number/3398195
  primes, powers = house.prime_division.transpose
  exponents = powers.map { |i| (0..i).to_a }

  exponents.shift.product(*exponents).map do |powers|
    primes.zip(powers).map { |prime, power| prime**power }.inject(:*)
  end
end

def first_house(target, multiplier)
  house = 1
  elves = [1]

  loop do
    total = elves.sum
    break if total * multiplier >= target

    house += 1
    elves = elves_for(house)
    elves = yield(house, elves) if block_given?
  end

  house
end

door = first_house(GIFTS, 10)
solve!("First house to receive #{GIFTS}:", door)

door = first_house(GIFTS, 11) do |house, elves|
  cutoff = house / 50
  elves.reject { |elf| elf < cutoff }
end
solve!("First house to receive #{GIFTS} (lazy elves):", door)
