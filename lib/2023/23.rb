require "matrix"
require "rb_heap/heap"

MOVEMENTS = [Vector[0, -1], Vector[1, 0], Vector[0, 1], Vector[-1, 0]]
MAP = INPUT.split("\n").each_with_index.each_with_object({}) do |(line, y), map|
  line.chars.each_with_index { |c, x| map[Vector[x, y]] = c }
end

x1, x2 = MAP.keys.map { |p| p[0] }.minmax
y1, y2 = MAP.keys.map { |p| p[1] }.minmax

STARTS = (x1..x2).map { |x| Vector[x, y1] }.detect { |p| MAP[p] == "." }
ENDS = (x1..x2).map { |x| Vector[x, y2] }.detect { |p| MAP[p] == "." }

def slope_movements(tile)
  case tile
  when ">" then [Vector[1, 0]]
  when "<" then [Vector[-1, 0]]
  when "^" then [Vector[0, -1]]
  when "v" then [Vector[0, 1]]
  when "." then MOVEMENTS
  end
end

def compress(map)
  edges = map.each_with_object({}) do |(position, c), neighbors|
    next if c == "#"

    movements = yield(c)
    neighbors[position] = movements.filter_map do |move|
      coord = position + move
      next if map[coord].nil? || map[coord] == "#"

      [coord, 1]
    end.to_h
  end

  loop do
    coord, neighbors = edges.detect { |coord, connections| connections.size == 2 }
    break if coord.nil?

    a, ca, b, cb = neighbors.flatten
    edges[a].delete(coord)
    edges[b].delete(coord)

    cost = ca + cb

    edges[a][b] = cost
    edges[b][a] = cost

    edges.delete(coord)
  end

  edges
end

def longest_path(edges, from:, to:, seen: {from => true}, cost: 0)
  return cost if from == to

  edges[from].filter_map do |neighbor, steps|
    next if seen[neighbor]

    longest_path(
      edges,
      from: neighbor,
      to:,
      seen: seen.merge(neighbor => true),
      cost: cost + steps
    )
  end.max
end

edges = compress(MAP) { |t| slope_movements(t) }
solve!("The longest path to the end is:", longest_path(edges, from: STARTS, to: ENDS))

edges = compress(MAP) { MOVEMENTS }
solve!("The longest path to the end without slopes is:", longest_path(edges, from: STARTS, to: ENDS))
