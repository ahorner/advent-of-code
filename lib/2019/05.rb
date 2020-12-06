require_relative "./shared/intcode"

outputs = Computer.new(INTCODE).run(inputs: [1])
puts "The diagnostic code for the air conditioner unit is:", outputs.last, "\n"

outputs = Computer.new(INTCODE).run(inputs: [5])
puts "The diagnostic code for the thermal radiator controller is:", outputs.last
