require_relative "./shared/assembunny"

registers = Hash.new(0)
computer = Assembunny.new(registers)
computer.run(INSTRUCTIONS)

puts "Register 'a' contains:", computer.registers["a"], nil

registers = Hash.new(0).tap { |h| h["c"] = 1 }
computer = Assembunny.new(registers)
computer.run(INSTRUCTIONS)

puts "After setting register 'c' to 1, register 'a' contains:", computer.registers["a"]
