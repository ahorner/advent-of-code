inputs = INPUT.split("-").map(&:to_i)
RANGE = (inputs[0]..inputs[1]).freeze

def valid_password?(number)
  digits = number.to_s.chars.map(&:to_i)
  comparisons = digits.each_cons(2)

  digits.count == 6 &&
    comparisons.none? { |(a, b)| a > b } &&
    comparisons.any? { |(a, b)| a == b }
end

count = RANGE.count { |number| valid_password?(number) }
puts "The number of valid passwords is:", count, "\n"

def strict_password?(number)
  digits = number.to_s.chars.map(&:to_i)
  comparisons = digits.each_cons(2)

  digits.count == 6 &&
    comparisons.none? { |(a, b)| a > b } &&
    digits.chunk(&:to_i).any? { |_, group| group.size == 2 }
end

count = RANGE.count { |number| strict_password?(number) }
puts "The number of (strict) valid passwords is:", count
