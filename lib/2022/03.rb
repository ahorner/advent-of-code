RUCKSACKS = INPUT.split("\n").map do |row|
  items = row.chars.to_a
  items.each_slice(items.size / 2).to_a
end

def score_for(item)
  case item
  when /[A-Z]/ then item.ord - "A".ord + 27
  when /[a-z]/ then item.ord - "a".ord + 1
  end
end

shared = RUCKSACKS.flat_map { |rucksack| rucksack.reduce(&:&) }

solve!(
  "The sum of shared item priorities is:",
  shared.sum { |item| score_for(item) },
)

badges = RUCKSACKS.each_slice(3).map { |elves| elves.map(&:flatten).reduce(&:&)[0] }

solve!(
  "The sum of badge priorities is:",
  badges.sum { |item| score_for(item) },
)
