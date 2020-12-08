LINES = INPUT.split("\n")

def evaluated_difference(line)
  line.length - eval(line).length # rubocop:disable Security/Eval
end

total = LINES.map { |line| evaluated_difference(line) }.sum

solve!("The original strings are longer by:", total)

def escaped_difference(line)
  line.inspect.length - line.length
end

total = LINES.map { |line| escaped_difference(line) }.sum

solve!("The escaped strings are longer by:", total)
