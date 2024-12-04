require "matrix"

ADJACENCIES = ([-1, 0, 1].repeated_permutation(2).to_a - [[0, 0]]).map { |x, y| Vector[x, y] }
GRID = INPUT.split("\n").each_with_index.each_with_object({}) do |(line, y), grid|
  line.chars.each_with_index do |cell, x|
    grid[Vector[x, y]] = cell
  end
end

def search_for(grid, target)
  search = target.chars

  coords = grid.filter_map { |(position, value)| position if value == search[0] }
  searches = coords.flat_map do |c|
    ADJACENCIES.filter_map do |a|
      test = c + a
      [test, a] if grid[test] == search[1]
    end
  end

  search.drop(2).inject(searches) do |matches, query|
    matches.filter_map do |(c, d)|
      test = c + d
      [test, d] if grid[test] == query
    end
  end
end

solve!("The XMAS count is:", search_for(GRID, "XMAS").count)

diagonal_centers = search_for(GRID, "MAS").each_with_object(Hash.new { |h, k| h[k] = [] }) do |(c, d), results|
  results[c - d] << d if d[0].abs == d[1].abs
end
x_mases = diagonal_centers.select { |_, vectors| vectors.length > 1 }.count do |c, vectors|
  vectors.combination(2).count { |da, db| da.inner_product(db) == 0 }
end

solve!("The X-MAS count is:", x_mases)
