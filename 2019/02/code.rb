INTCODE = INPUT.split(",").map(&:to_i).freeze

def process(program, pointer)
  operation, advance =
    case program[pointer]
    when 1 then :+
    when 2 then :*
    when 99 then nil
    else raise "Bad instruction at #{pointer} (#{program[pointer]})"
    end

  return nil unless operation

  first_input = program[pointer + 1]
  second_input = program[pointer + 2]
  output = program[pointer + 3]

  program[output] = program[first_input].public_send(operation, program[second_input])

  pointer + 4
end

def run(intcode, noun, verb)
  program = intcode.dup
  program[1] = noun
  program[2] = verb

  pointer = 0

  loop do
    pointer = process(program, pointer)
    break unless pointer
  end

  program[0]
end

output = run(INTCODE, 12, 2)
puts "The output of the program is:", output, "\n"

TARGET_OUTPUT = 19690720

def search(intcode, target)
  (0..99).each { |n| (0..99).each { |v| return [n, v] if run(intcode, n, v) == target } }
end

noun, verb = search(INTCODE, TARGET_OUTPUT)

puts "The noun/verb code for the target output is:", noun * 100 + verb
