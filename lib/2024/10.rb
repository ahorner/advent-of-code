require "matrix"

MAP = INPUT.split("\n").each_with_index.each_with_object({}) do |(line, y), map|
  line.chars.each_with_index do |c, x|
    map[Vector[x, y]] = c.to_i unless c == "."
  end
end

TRAILHEADS = MAP.keys.select { |position| MAP[position] == 0 }
ADJACENCIES = [Vector[1, 0], Vector[0, 1], Vector[-1, 0], Vector[0, -1]]

def score_map(map, peak_scores)
  scores = peak_scores.dup

  8.downto(0).each do |height|
    map.keys.each do |position|
      next unless map[position] == height

      ADJACENCIES.each do |move|
        next unless map[position + move] == height + 1
        scores[position] += scores[position + move]
      end
    end
  end

  scores
end

def peaks_map(map)
  reachable = Hash.new { |h, k| h[k] = Set.new }
  map.keys.each { |position| reachable[position] << position if map[position] == 9 }

  score_map(map, reachable).to_h { |position, peaks| [position, peaks.count] }
end

scores = peaks_map(MAP)
solve!("The sum of trail scores is:", TRAILHEADS.sum { |trailhead| scores[trailhead] })

def ratings_map(map)
  ratings = Hash.new(0)
  map.keys.each { |position| ratings[position] = 1 if map[position] == 9 }

  score_map(map, ratings)
end

scores = ratings_map(MAP)
solve!("The sum of trail ratings is:", TRAILHEADS.sum { |trailhead| scores[trailhead] })
