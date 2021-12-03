NUMBERS = INPUT.split("\n").map { |number| number.chars.map(&:to_i) }
LENGTH = NUMBERS.first.length

def most_common_for(numbers)
  LENGTH.times.map do |i|
    ones = numbers.count { |n| n[i] == 1 }
    zeroes = numbers.length - ones

    ones >= zeroes ? 1 : 0
  end
end

def value_for(digits)
  digits.join.to_i(2)
end

epsilon = most_common_for(NUMBERS)
gamma = epsilon.map { |i| i == 1 ? 0 : 1 }

solve!("The system's power consumption is:", value_for(epsilon) * value_for(gamma))

def filtered_value(numbers, operator)
  LENGTH.times.each do |i|
    ones = numbers.count { |n| n[i] == 1 }
    zeroes = numbers.length - ones
    filter_by = ones.public_send(operator, zeroes) ? 1 : 0

    numbers = numbers.select { |n| n[i] == filter_by }

    break numbers.first if numbers.one?
  end
end

oxygen_generator = filtered_value(NUMBERS, :>=)
co2_scrubber = filtered_value(NUMBERS, :<)

solve!("The system's life support rating is:", value_for(oxygen_generator) * value_for(co2_scrubber))
