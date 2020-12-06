GROUPED_ANSWERS = INPUT.split("\n\n").map do |group|
  group.split("\n").map { |person| person.split("") }
end

solve!("The number of positive responses is:",
  GROUPED_ANSWERS.sum { |group| group.reduce(:|).count })
solve!("The number of unanimous positive responses is:",
  GROUPED_ANSWERS.sum { |group| group.reduce(:&).count })
