BUYERS = INPUT.split("\n").map(&:to_i)
PRUNE = 16777216

def evolve(number)
  number = ((number * 64) ^ number) % PRUNE
  number = ((number / 32) ^ number) % PRUNE
  ((number * 2048) ^ number) % PRUNE
end

def secret(seed, iterations = 2000)
  iterations.times.inject(seed) { |n| evolve(n) }
end

solve!("The sum of secret values is:", BUYERS.sum { |buyer| secret(buyer) })

def prices(seed, iterations = 2000)
  number = seed
  deltas = []

  iterations.times.map do |i|
    last = number
    number = evolve(last)

    deltas << (number % 10) - (last % 10)
    deltas.shift if deltas.size > 4

    [number % 10, deltas.hash]
  end
end

bananas = BUYERS.each_with_object(Hash.new(0)) do |buyer, totals|
  seen = {}
  prices(buyer).each do |price, changes|
    next if seen[changes]

    seen[changes] = true
    totals[changes] += price
  end
end

solve!("The maximum number of bananas is:", bananas.values.max)
