CHANGES = INPUT.split("\n").map(&:to_i)

solve!("The final total frequency is:", CHANGES.sum)

require "set"
frequencies = Set.new
frequency = 0

loop do
  change = CHANGES[frequencies.size % CHANGES.size]
  frequencies << frequency
  frequency += change

  break if frequencies.include?(frequency)
end

solve!("The first frequency achieved twice is:", frequency)
