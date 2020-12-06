require_relative "./shared/intcode"

puts "The BOOST keycode is:", Computer.new(INTCODE).run(inputs: [1]).last, "\n"
puts "The distress signal coordinates are:", Computer.new(INTCODE).run(inputs: [2]).last
