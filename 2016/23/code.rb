def value(registers, string)
  string =~ /-?\d+/ ? string.to_i : registers[string]
end

def valid?(instruction, x, y, z)
  arity = [x, y, z].compact.count
  case instruction.to_sym
  when :mul then arity = 3
  when :cpy, :jnz then arity == 2
  else arity == 1
  end
end

def toggled(line)
  instruction, x, y = line
  new_line =
    case instruction.to_sym
    when :inc then ["dec", x, y]
    when :dec, :tgl then ["inc", x, y]
    when :jnz then ["cpy", x, y]
    else ["jnz", x, y]
    end

  new_line.compact
end

def parse(instructions, line, registers)
  instruction, x, y, z = instructions[line]

  if valid?(instruction, x, y, z)
    case instruction.to_sym
    when :cpy
      registers[y] = value(registers, x)
    when :inc
      registers[x] += 1
    when :dec
      registers[x] -= 1
    when :jnz
      line += (value(registers, y) - 1) if value(registers, x) != 0
    when :tgl
      toggle_index = line + value(registers, x)
      toggle_line = instructions[toggle_index]
      instructions[toggle_index] = toggled(toggle_line) if toggle_line
    when :mul
      registers[x] += value(registers, y) * value(registers, z)
    end
  end

  [line + 1, instructions]
end

def run(registers)
  instructions = optimize(INPUT.split("\n").map { |l| l.split(" ") })

  line = 0
  line, instructions = parse(instructions, line, registers) while instructions[line]
end

def optimize(instructions)
  instructions.each_cons(6).with_index do |lines, index|
    if lines.map(&:first).map(&:to_sym) == [:cpy, :inc, :dec, :jnz, :dec, :jnz]
      instructions[index] = ["mul", lines[1][1], lines[0][1], lines[-1][1]]
      5.times { |i| instructions[index + i + 1] = ["jnz", 0, 0] }
    end
  end

  instructions
end

registers = Hash.new(0)
registers["a"] = 7
run(registers)

puts "Register 'a' contains:", registers["a"], nil

registers = Hash.new(0)
registers["a"] = 12
run(registers)

puts "After updating the egg count, register 'a' contains:", registers["a"]
