RANGES = INPUT.split("\n").map do |pair|
  pair.split(",").map do |range|
    begins, ends = range.split("-").map(&:to_i)
    begins..ends
  end
end

solve!(
  "The number of pairs where one range fully contains the other is:",
  RANGES.count { |a, b| a.cover?(b) || b.cover?(a) },
)

solve!(
  "The number of pairs with any overlap in their ranges is:",
  RANGES.count { |a, b| a.begin <= b.end && a.end >= b.begin },
)
