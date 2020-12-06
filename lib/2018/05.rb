OPPOSITE_INDICATOR = ("A".ord - "a".ord).abs

def opposite?(first, second)
  (first - second).abs == OPPOSITE_INDICATOR
end

def reduce(polymer)
  polymer.bytes.each_with_object([]) do |c, result|
    result.empty? || !opposite?(result.last, c) ? result << c : result.pop
  end.pack("c*")
end

polymer = reduce(INPUT)
solve!("The polymer size after reduction is:", polymer.size)

sizes = ("a".."z").map { |c| reduce(polymer.gsub(/#{c}/i, "")).size }
solve!("The minimum polymer size (with removal) is:", sizes.min)
