LINES = INPUT.split("\n").freeze

sum = LINES.reduce(0) do |total, line|
  numbers = line.scan(/\d/)
  value = numbers.first.to_i * 10 + numbers.last.to_i

  total + value
end

solve!("The sum of calibration values is:", sum)

REPLACEMENTS = {
  "one" => 1,
  "two" => 2,
  "three" => 3,
  "four" => 4,
  "five" => 5,
  "six" => 6,
  "seven" => 7,
  "eight" => 8,
  "nine" => 9
}.freeze

sum = LINES.reduce(0) do |total, line|
  numbers = line.chars.each_with_index.each_with_object([]) do |(c, i), digits|
    translated = line[i..].sub(Regexp.union(REPLACEMENTS.keys), REPLACEMENTS)
    digits << translated[0] if translated[0] =~ /\d/
  end.map(&:to_i)

  value = numbers.first.to_i * 10 + numbers.last.to_i
  total + value
end

solve!("The sum of calibration values with word digits is:", sum)
