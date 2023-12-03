require_relative "shared/intcode"

outputs = Computer.new(INTCODE).run(inputs: [1])
solve!("The diagnostic code for the air conditioner unit is:", outputs.last)

outputs = Computer.new(INTCODE).run(inputs: [5])
solve!("The diagnostic code for the thermal radiator controller is:", outputs.last)
