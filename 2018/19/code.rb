require "prime"

ip, instructions = INPUT.split("\n").partition.with_index { |_, i| i == 0 }

POINTER = ip.first.match(/\#ip (?<ip>\d+)/)[:ip].to_i
INSTRUCTIONS = instructions.map do |line|
  line = line.split
  [line.shift.to_sym, *line.map(&:to_i)]
end

def result(registers, opcode, a, b, c)
  registers = registers.dup

  registers[c] =
    case opcode
    when :addr then registers[a] + registers[b]
    when :addi then registers[a] + b
    when :mulr then registers[a] * registers[b]
    when :muli then registers[a] * b
    when :banr then registers[a] & registers[b]
    when :bani then registers[a] & b
    when :borr then registers[a] | registers[b]
    when :bori then registers[a] | b
    when :setr then registers[a]
    when :seti then a
    when :gtir then a > registers[b] ? 1 : 0
    when :gtri then registers[a] > b ? 1 : 0
    when :gtrr then registers[a] > registers[b] ? 1 : 0
    when :eqir then a == registers[b] ? 1 : 0
    when :eqri then registers[a] == b ? 1 : 0
    when :eqrr then registers[a] == registers[b] ? 1 : 0
    end

  registers
end

# NOTE: Part 2 of this puzzle takes an unrealistically long amount of time to
# run, so a reasonable solution requires analyzing the code in the input to
# determine what it's actually doing. The instructions boil down to "sum the
# factors of N", where N is some arbitrary large number. I've left the
# calculation for N semi-dynamic, so it will hopefully work for other inputs,
# based on the assumption that every input shares the same general structure.
def total_for(registers)
  jump_to = INSTRUCTIONS.first[2]
  registers[POINTER] = jump_to + 1

  loop do
    pointer = registers[POINTER]
    break if pointer < jump_to

    registers = result(registers, *INSTRUCTIONS[pointer])
    registers[POINTER] += 1
  end

  registers.max
end

def factors_of(number)
  primes, powers = number.prime_division.transpose
  exponents = powers.map { |i| (0..i).to_a }
  exponents.shift.product(*exponents).map do |powers|
    primes.zip(powers).map { |prime, power| prime**power }.inject(:*)
  end
end

def run(registers)
  factors_of(total_for(registers)).sum
end

puts "The value of register 0 is:", run([0, 0, 0, 0, 0, 0]), nil
puts "The value of register 0 (starting at 1) is:", run([1, 0, 0, 0, 0, 0])
