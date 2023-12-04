EMPTY = "."
SCHEMATIC = INPUT.split("\n").each_with_index.each_with_object(Hash.new(EMPTY)) do |(line, y), grid|
  line.chars.each_with_index { |c, x| grid[[x, y]] = c }
end

def part_at?(schematic, y, xs)
  edges = [
    [xs[0] - 1, y - 1],
    [xs[0] - 1, y],
    [xs[0] - 1, y + 1],
    [xs[-1] + 1, y - 1],
    [xs[-1] + 1, y],
    [xs[-1] + 1, y + 1]
  ]

  edges.any? { |coord| schematic[coord] != EMPTY } ||
    xs.any? { |x| schematic[[x, y - 1]] != EMPTY || schematic[[x, y + 1]] != EMPTY }
end

Part = Data.define(:id, :row, :columns) do
  def adjacent_to?((x, y))
    (row - 1 <= y && row + 1 >= y) &&
      (columns[0] - 1 <= x && columns[-1] + 1 >= x)
  end
end

HEIGHT = SCHEMATIC.keys.map(&:last).max
WIDTH = SCHEMATIC.keys.map(&:first).max

PARTS = (0..HEIGHT).flat_map do |y|
  (0..WIDTH)
    .chunk { |x| SCHEMATIC[[x, y]].match?(/\d/) }
    .select(&:first)
    .map(&:last)
    .select { |columns| part_at?(SCHEMATIC, y, columns) }
    .map do |columns|
      Part.new(
        id: columns.map { |x| SCHEMATIC[[x, y]] }.join.to_i,
        row: y,
        columns:
      )
    end
end

solve!("The sum of part IDs is:", PARTS.sum(&:id))

GEAR = "*"
gears = SCHEMATIC.select { |coord, c| c == GEAR && PARTS.count { |p| p.adjacent_to?(coord) } == 2 }.map(&:first)
ratios = gears.map { |coord| PARTS.select { |p| p.adjacent_to?(coord) }.map(&:id).reduce(:*) }

solve!("The sum of gear ratios is:", ratios.sum)
