INSTRUCTIONS = INPUT.split("\n").map(&:split)

class Assembunny
  attr_reader :registers, :outputs

  def initialize(registers)
    @registers = registers
    @outputs = []
  end

  def run(instructions)
    instructions = optimize(instructions.dup)

    line = 0
    loop do
      line, instructions, output = parse(instructions, line)

      yield output if output
      break unless instructions[line]
    end
  end

  private

  def value(string)
    /-?\d+/.match?(string.to_s) ? string.to_i : registers[string]
  end

  def valid?(instruction, x, y, z)
    arity = [x, y, z].compact.count
    arity ==
      case instruction.to_sym
      when :mul then 3
      when :cpy, :jnz then 2
      else 1
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

  def parse(instructions, line)
    instruction, x, y, z = instructions[line]
    output = nil

    if valid?(instruction, x, y, z)
      case instruction.to_sym
      when :cpy
        registers[y] = value(x)
      when :inc
        registers[x] += 1
      when :dec
        registers[x] -= 1
      when :jnz
        line += (value(y) - 1) if value(x) != 0
      when :tgl
        toggle_index = line + value(x)
        toggle_line = instructions[toggle_index]
        instructions[toggle_index] = toggled(toggle_line) if toggle_line
      when :mul
        registers[x] += value(y) * value(z)
      when :out
        output = value(x)
      end
    end

    [line + 1, instructions, output]
  end

  def optimize(instructions)
    instructions.each_cons(6).with_index do |lines, index|
      if lines.map(&:first).map(&:to_sym) == %i[cpy inc dec jnz dec jnz]
        instructions[index] = ["mul", lines[1][1], lines[0][1], lines[-1][1]]
        5.times { |i| instructions[index + i + 1] = ["jnz", 0, 0] }
      end
    end

    instructions
  end
end
