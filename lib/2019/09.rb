require_relative "shared/intcode"

solve!("The BOOST keycode is:", Computer.new(INTCODE).run(inputs: [1]))
solve!("The distress signal coordinates are:", Computer.new(INTCODE).run(inputs: [2]))
