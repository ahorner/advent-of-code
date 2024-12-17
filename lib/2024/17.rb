registers, program = INPUT.split("\n\n")

PROGRAM = program.split(" ").last.split(",").map(&:to_i)

REGISTER_MATCHER = /\ARegister (?<label>.+): (?<value>-?\d+)\z/
REGISTERS = registers.split("\n").each_with_object({}) do |register, data|
  match = register.match(REGISTER_MATCHER)
  data[match[:label].to_sym] = match[:value].to_i
end

OPCODES = %i[adv bxl bst jnz bxc out bdv cdv]
OPERATIONS = {}

def combo_operand(registers, operand)
  if operand <= 3
    operand
  elsif operand == 4
    registers[:A]
  elsif operand == 5
    registers[:B]
  elsif operand == 6
    registers[:C]
  else
    raise "Invalid program"
  end
end

def run(instructions, registers)
  registers = registers.dup
  outputs = []

  pointer = 0
  loop do
    break if pointer >= instructions.length

    operator = instructions[pointer]
    operand = instructions[pointer + 1]

    case OPCODES[operator]
    when :adv
      registers[:A] = registers[:A] / (2**combo_operand(registers, operand))
    when :bxl
      registers[:B] = registers[:B] ^ operand
    when :bst
      registers[:B] = combo_operand(registers, operand) % 8
    when :jnz
      if registers[:A] != 0
        pointer = operand
        next
      end
    when :bxc
      registers[:B] = registers[:B] ^ registers[:C]
    when :out
      outputs << combo_operand(registers, operand) % 8
    when :bdv
      registers[:B] = registers[:A] / (2**combo_operand(registers, operand))
    when :cdv
      registers[:C] = registers[:A] / (2**combo_operand(registers, operand))
    end

    pointer += 2
  end

  outputs
end

solve!("The output after running is:", run(PROGRAM, REGISTERS).join(","))

def a_value(program, i = program.length - 1, value = 0)
  return value if i < 0

  registers = REGISTERS.dup
  value = value << 3

  (value...(value + 8)).each do |j|
    registers[:A] = j
    output = run(PROGRAM, registers)

    if output[0] == program[i]
      final = a_value(program, i - 1, j)
      return final if final > 0
    end
  end

  -1
end

solve!("The minimal A value that copies the program is:", a_value(PROGRAM))
