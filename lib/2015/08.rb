LINES = INPUT.split("\n")

def evaluated_difference(line)
  line.length - eval(line).length # rubocop:disable Security/Eval
end

total = LINES.map { |line| evaluated_difference(line) }.inject(:+)

puts "The original strings are longer by:", total, nil

def escaped_difference(line)
  line.inspect.length - line.length
end

total = LINES.map { |line| escaped_difference(line) }.inject(:+)

puts "The escaped strings are longer by:", total
