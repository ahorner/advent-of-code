def parse(instruction, line, registers)
  parsed_instruction = instruction.split(" ")
  instr = parsed_instruction.first

  case instr
  when "hlf"
    register = parsed_instruction.last
    registers[register] /= 2
    line += 1
  when "tpl"
    register = parsed_instruction.last
    registers[register] *= 3
    line += 1
  when "inc"
    register = parsed_instruction.last
    registers[register] += 1
    line += 1
  when "jmp"
    jump = parsed_instruction.last
    line += jump.to_i
  when "jie"
    register = parsed_instruction[1].chomp(",")
    jump = parsed_instruction[2]
    line += registers[register].even? ? jump.to_i : 1
  when "jio"
    register = parsed_instruction[1].chomp(",")
    jump = parsed_instruction[2]
    line += registers[register] == 1 ? jump.to_i : 1
  end

  line
end

INSTRUCTIONS = INPUT.split("\n")

def run(registers)
  line = 0
  line = parse(INSTRUCTIONS[line], line, registers) while INSTRUCTIONS[line]
end

registers = Hash.new(0)
run(registers)

puts "Register B:", registers["b"], nil

registers = Hash.new(0)
registers["a"] = 1
run(registers)

puts "Register B (with A starting at 1):", registers["b"]
