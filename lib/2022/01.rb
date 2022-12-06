ELVES = INPUT.split("\n\n").map { |rows| rows.split("\n").map(&:to_i) }

solve!(
  "The maximum calorie count carried by any elf is:",
  ELVES.map(&:sum).max
)

solve!(
  "The total calorie count of the top three elves is:",
  ELVES.map(&:sum).sort.last(3).sum
)
