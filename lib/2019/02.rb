require_relative "./shared/intcode"

def run(noun, verb)
  program = INTCODE.dup
  program[1] = noun
  program[2] = verb

  computer = Computer.new(program)
  computer.run

  computer[0]
end

SETTING ||= [12, 2].freeze
output = run(*SETTING)
solve!("The output of the program is:", output)

TARGET_OUTPUT = 19_690_720

def search(_intcode, target)
  100.times { |n| 100.times { |v| return [n, v] if run(n, v) == target } }
end

noun, verb = search(INTCODE, TARGET_OUTPUT)

solve!("The noun/verb code for the target output is:", (noun * 100) + verb)
