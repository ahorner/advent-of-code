INSTRUCTIONS = INPUT.split("\n")

def value(registers, string)
  string =~ /-?\d+/ ? string.to_i : registers[string]
end

def parse(instruction, line, registers)
  instruction, x, y = instruction.split(" ")

  case instruction.to_sym
  when :cpy
    registers[y] = value(registers, x)
  when :inc
    registers[x] += 1
  when :dec
    registers[x] -= 1
  when :jnz
    line += (y.to_i - 1) if value(registers, x) != 0
  end

  line + 1
end

def run(registers)
  line = 0
  line = parse(INSTRUCTIONS[line], line, registers) while INSTRUCTIONS[line]
end

registers = Hash.new(0)
run(registers)

puts "Register 'a' contains:", registers["a"], nil

registers = Hash.new(0)
registers["c"] = 1
run(registers)

puts "After setting register 'c' to 1, register 'a' contains:", registers["a"]
