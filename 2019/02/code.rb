require_relative "../shared/intcode"

def run(noun, verb)
  program = INTCODE.dup
  program[1] = noun
  program[2] = verb

  computer = Computer.new(program)
  computer.run

  computer[0]
end

output = run(12, 2)
puts "The output of the program is:", output, "\n"

TARGET_OUTPUT = 19690720

def search(intcode, target)
  (0..99).each { |n| (0..99).each { |v| return [n, v] if run(n, v) == target } }
end

noun, verb = search(INTCODE, TARGET_OUTPUT)

puts "The noun/verb code for the target output is:", noun * 100 + verb
