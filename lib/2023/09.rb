REPORT = INPUT.split("\n").map { |line| line.split(" ").map(&:to_i) }

def decompose(history)
  sequences = [history]

  loop do
    break sequences if history.all? { |d| d == 0 }

    history = history.each_cons(2).each_with_object([]) { |(a, b), gaps| gaps << b - a }
    sequences << history
  end
end

def extrapolate_next(history)
  decompose(history).sum(&:last)
end

def extrapolate_previous(history)
  decompose(history).reverse.reduce(0) do |gap, sequence|
    sequence.first - gap
  end
end

solve!("The sum of next values is:", REPORT.sum { |history| extrapolate_next(history) })
solve!("The sum of previous values is:", REPORT.sum { |history| extrapolate_previous(history) })
