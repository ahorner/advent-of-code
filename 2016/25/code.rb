def value(registers, string)
  string =~ /-?\d+/ ? string.to_i : registers[string]
end

def parse(instructions, line, registers, output)
  instruction, x, y, z = instructions[line]

  case instruction.to_sym
  when :cpy
    registers[y] = value(registers, x)
  when :inc
    registers[x] += 1
  when :dec
    registers[x] -= 1
  when :jnz
    line += (value(registers, y) - 1) if value(registers, x) != 0
  when :mul
    registers[x] += value(registers, y) * value(registers, z)
  when :out
    output << value(registers, x)
  end

  line + 1
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

def sequence(&generator)
  Enumerator.new do |yielder|
    n = 0
    loop do
      yielder.yield generator.call(n)
      n = n + 1
    end
  end
end

# There are a handful of false positives if you set this too low.
SIGNAL_CUTOFF = 8
CLOCK_SIGNAL = sequence { |i| i.even? ? 0 : 1 }.freeze
INSTRUCTIONS = optimize(INPUT.split("\n").map { |l| l.split(" ") })

def run(start)
  instructions = INSTRUCTIONS
  output = []
  line = 0

  registers = Hash.new(0)
  registers["a"] = start

  while instructions[line]
    line = parse(instructions, line, registers, output)

    if output != CLOCK_SIGNAL.take(output.length)
      return
    elsif output.length == SIGNAL_CUTOFF
      return start
    end
  end
end

start = nil
i = 0

while start.nil?
  start = run(i)
  i += 1
end

puts "The first number that initiates a clock sequence is:", start, nil
