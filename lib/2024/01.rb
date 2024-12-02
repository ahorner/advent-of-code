numbers = INPUT.split("\n").map { |line| line.split(/\s+/) }

FIRST = numbers.map(&:first).map(&:to_i)
SECOND = numbers.map(&:last).map(&:to_i)

solve! "The total of distances is:", FIRST.sort.zip(SECOND.sort).sum { |a, b| (b - a).abs }
solve! "The total of similarity scores is:", FIRST.sum { |number| number * SECOND.count(number) }
