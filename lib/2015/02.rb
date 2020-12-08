def boxes
  INPUT.split("\n").map do |line|
    line.split("x").map(&:to_i)
  end
end

def area(w, h, l)
  (2 * w * h) + (2 * w * l) + (2 * h * l) + [w * h, w * l, h * l].min
end

def total_area
  boxes.sum { |edges| area(*edges) }
end

solve!("Total sqft of wrapping paper:", total_area)

def length(w, h, l)
  smallest = [w, h, l].sort.take(2)
  wrapping = smallest.sum { |edge| edge * 2 }
  bow = w * h * l

  wrapping + bow
end

def total_length
  boxes.sum { |edges| length(*edges) }
end

solve!("Total ft of ribbon:", total_length)
