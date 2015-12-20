require "prime"

GIFTS = INPUT.to_i

def elves_for(house)
  # Apologies to: http://stackoverflow.com/questions/3398159/all-factors-of-a-given-number/3398195
  primes, powers = house.prime_division.transpose
  exponents = powers.map { |i| (0..i).to_a }

  exponents.shift.product(*exponents).map do |powers|
    primes.zip(powers).map { |prime, power| prime ** power }.inject(:*)
  end
end

def first_house(elf_sum, &block)
  house = 1

  begin
    house += 1
    elves = elves_for(house)
    elves = yield(house, elves) if block_given?

    elf_total = elves.inject(:+)
  end while elf_total < elf_sum

  house
end

door = first_house(GIFTS / 10)
puts "First house to receive #{GIFTS}:", door, nil

door = first_house(GIFTS / 11) do |house, elves|
  cutoff = house / 50
  elves.reject { |elf| elf < cutoff }
end
puts "First house to receive #{GIFTS} (lazy elves):", door
