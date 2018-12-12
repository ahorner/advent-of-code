INITIAL_MATCHER = /initial state: (?<state>.+)/
CONVERSION_MATCHER = /(?<pattern>.+) => (?<result>.)/

RULES = Hash.new(".")

INPUT.split("\n").each do |line|
  case line
  when INITIAL_MATCHER then INITIAL = $~[:state]
  when CONVERSION_MATCHER then RULES[$~[:pattern]] = $~[:result]
  end
end

def result(state, offset)
  final = ""
  ".....#{state}.....".chars.each_cons(5) { |pot| final << RULES[pot.join("")] }
  [final, offset + 3]
end

def score(state, offset)
  state.chars.map.with_index { |c, i| c == "#" ? i - offset : 0 }.sum
end

def evolve(state, generations)
  offset = 0
  current_score = score(state, offset)
  score_deltas = []

  generations.times do |gen|
    state, offset = result(state, offset)
    new_score = score(state, offset)
    score_deltas << new_score - current_score

    if score_deltas.size >= 3 && score_deltas.last(3).uniq.size == 1
      current_score += score_deltas.last * (generations - gen)
      break
    end

    current_score = new_score
  end

  current_score
end

puts "The score after 20 generations is:", evolve(INITIAL, 20), nil
puts "The score after 50B generations is:", evolve(INITIAL, 50_000_000_000)
