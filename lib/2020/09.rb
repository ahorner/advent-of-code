LIST = INPUT.split("\n").map(&:to_i)
PREAMBLE ||= 25

value = LIST.each_cons(PREAMBLE + 1) do |list|
  number = list[-1]
  preamble = list[0..-2]

  break number if preamble.combination(2).none? { |combo| combo.sum == number }
end

solve!("The first number that doesn't fit its preamble is:", value)

def weakness(value)
  comparison = LIST[0]
  first = 0
  last = 0

  loop do
    if comparison < value
      last += 1
      break if last >= LIST.size

      comparison += LIST[last]
    elsif comparison > value
      comparison -= LIST[first]
      first += 1
    elsif comparison == value
      range = LIST[first..last]
      break range.min + range.max
    end
  end
end

solve!("The encryption weakness of our list is:", weakness(value))
