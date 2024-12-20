patterns, designs = INPUT.split("\n\n")
PATTERNS = patterns.split(", ")
DESIGNS = designs.split("\n")

def possibilities(design, patterns, known = {})
  return 1 if design.nil? || design.empty?

  known[design] ||= patterns.sum do |pattern|
    next 0 unless design.start_with?(pattern)
    possibilities(design[pattern.length..], patterns, known)
  end
end

solve!("The number of possible designs is:", DESIGNS.count { |design| possibilities(design, PATTERNS) > 0 })
solve!("The number of unique constructions is:", DESIGNS.sum { |design| possibilities(design, PATTERNS) })
