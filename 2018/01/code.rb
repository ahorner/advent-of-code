CHANGES = INPUT.split("\n").map(&:to_i)

puts "The final total frequency is:", CHANGES.sum, nil

require "set"
frequencies = Set.new
frequency = nil

loop do
  change = CHANGES[frequencies.size % CHANGES.size]
  frequency = frequency.to_i + change
  break if frequencies.include?(frequency)

  frequencies << frequency
end

puts "The first frequency achieved twice is:", frequency
