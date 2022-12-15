base, *conversions = INPUT.split("\n").reject(&:empty?)

BASE = base.chars.freeze
CONVERSION_MATCHER = /\A(?<pair>[A-Z]{2}) -> (?<insert>[A-Z])\z/
CONVERSIONS = conversions.each_with_object({}) do |line, mappings|
  match = line.match(CONVERSION_MATCHER)
  mappings[match[:pair].chars] = match[:insert]
end.freeze

def score_after(steps:)
  pairs = BASE.each_cons(2).each_with_object(Hash.new(0)) { |pair, counts| counts[pair] += 1 }

  steps.times do
    pairs = pairs.each_with_object(Hash.new(0)) do |(k, v), updated|
      insert = CONVERSIONS[k]
      updated[[k[0], insert]] += v
      updated[[insert, k[1]]] += v
    end
  end

  elements = pairs.each_with_object(Hash.new(0)) { |(k, v), totals| totals[k[0]] += v }
  elements[BASE.last] += 1

  low, high = elements.values.minmax
  high - low
end

solve!("The difference between most/least common element after 10 steps is:", score_after(steps: 10))
solve!("The difference between most/least common element after 40 steps is:", score_after(steps: 40))
