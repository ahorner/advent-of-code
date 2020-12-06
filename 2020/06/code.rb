GROUPED_ANSWERS = INPUT.split("\n\n").map do |group|
  group.split("\n").map { |person| person.split("") }
end

puts "The number of positive responses is:",
  GROUPED_ANSWERS.sum { |group| group.reduce(:|).count },
  "\n"
puts "The number of unanimous positive responses is:",
  GROUPED_ANSWERS.sum { |group| group.reduce(:&).count }
