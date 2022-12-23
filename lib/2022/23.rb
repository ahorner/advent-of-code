require "set"
require "matrix"

ELVES = INPUT.split("\n").flat_map.with_index do |line, y|
  line.chars.filter_map.with_index { |c, x| Vector[x, y] if c == "#" }
end.to_set

DIRECTIONS = {
  north: [Vector[0, -1], Vector[-1, -1], Vector[1, -1]],
  south: [Vector[0, 1], Vector[-1, 1], Vector[1, 1]],
  west: [Vector[-1, 0], Vector[-1, -1], Vector[-1, 1]],
  east: [Vector[1, 0], Vector[1, -1], Vector[1, 1]]
}
NEIGHBORS = DIRECTIONS.values.flatten.uniq
MOVES = DIRECTIONS.to_h { |k, v| [k, v.first] }

def proposals_for(elves, sequence)
  elves.each_with_object(Hash.new { |h, k| h[k] = [] }) do |coord, proposals|
    next if NEIGHBORS.none? { |dv| elves.include?(coord + dv) }

    proposed = sequence.find { |dir| DIRECTIONS[dir].none? { |dv| elves.include?(coord + dv) } }
    next unless proposed

    proposals[coord + MOVES[proposed]] << coord
  end
end

def apply(elves, proposals)
  proposals.each_with_object(elves.dup) do |(coord, candidates), final|
    next unless candidates.size == 1

    final.delete(candidates.first)
    final << coord
  end
end

elves = ELVES
sequence = DIRECTIONS.keys

10.times do
  proposals = proposals_for(elves, sequence)
  elves = apply(elves, proposals)

  sequence = sequence.rotate(1)
end

minx, maxx = elves.map { |coord| coord[0] }.minmax
miny, maxy = elves.map { |coord| coord[1] }.minmax

solve!(
  "The empty ground tile count after 10 rounds is:",
  (maxx - minx + 1) * (maxy - miny + 1) - elves.count
)

def diffusion_time(elves)
  sequence = DIRECTIONS.keys
  rounds = 1

  loop do
    proposals = proposals_for(elves, sequence)
    break rounds if proposals.none?
    elves = apply(elves, proposals)

    sequence = sequence.rotate(1)
    rounds += 1
  end
end

solve!(
  "The first round in which no elves move is:",
  diffusion_time(ELVES)
)
