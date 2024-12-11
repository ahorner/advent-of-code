STONES = INPUT.split(" ").map(&:to_i)

def stone_count(engraving, blink, max, counts = {})
  return 1 if blink > max

  counts["#{engraving}-#{blink}"] ||=
    if engraving == 0
      stone_count(1, blink + 1, max, counts)
    elsif engraving.to_s.length.even?
      length = engraving.to_s.length / 2
      stone_count(engraving.to_s[0, length].to_i, blink + 1, max, counts) +
        stone_count(engraving.to_s[length..].to_i, blink + 1, max, counts)
    else
      stone_count(engraving * 2024, blink + 1, max, counts)
    end
end

def stones_after(stones, blinks)
  stone_counts = {}
  stones.sum { |engraving| stone_count(engraving, 1, blinks, stone_counts) }
end

BLINKS ||= 25
solve!("The number of stones after #{BLINKS} blinks is:", stones_after(STONES, BLINKS))
solve!("The number of stones after 75 blinks is:", stones_after(STONES, 75))
