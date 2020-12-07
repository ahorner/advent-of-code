SEQUENCE = INPUT.split("").map(&:to_i)

def sum(sequence, gap = 1)
  sum = 0
  sequence.each_with_index do |i, j|
    comparison = (j + gap) % sequence.length
    sum += i if i == sequence[comparison]
  end

  sum
end

solve!("The sum of matching numbers is:", sum(SEQUENCE))
solve!("The sum of matching numbers (with a gap) is:", sum(SEQUENCE, SEQUENCE.length / 2))
