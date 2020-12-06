require_relative "../shared/assembunny"

registers = Hash.new(0).tap { |h| h["a"] = 7 }
computer = Assembunny.new(registers)
computer.run(INSTRUCTIONS)

puts "Register 'a' contains:", computer.registers["a"], nil

registers = Hash.new(0).tap { |h| h["a"] = 12 }
computer = Assembunny.new(registers)
computer.run(INSTRUCTIONS)

puts "After updating the egg count, register 'a' contains:", computer.registers["a"]
