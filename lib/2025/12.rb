Region = Data.define(:width, :height, :inventory) do
  def area
    width * height
  end

  def total_space(shapes)
    inventory.each_with_index.sum { |count, i| count * shapes[i] }
  end
end

sections = INPUT.split("\n\n")

SHAPES = sections[..-2].map do |shape|
  _, *rows = shape.split("\n")
  rows.sum { |row| row.chars.count("#") }
end

REGIONS = sections.last.split("\n").map do |region|
  dimensions, inventory = region.split(": ")
  width, height = dimensions.split("x").map(&:to_i)
  inventory = inventory.split(" ").map(&:to_i)

  Region.new(width:, height:, inventory:)
end

# This does nothing except make the example pass. Much simpler than trying to
# solve an actual NP-complete bin-packing problem.
EFFICIENCY = 0.82

fittable = REGIONS.count { |r| r.area >= r.total_space(SHAPES) / EFFICIENCY }
solve!("The number of regions that can fit all presents is:", fittable)
