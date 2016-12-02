def boxes
  INPUT.split("\n").map do |line|
    line.split("x").map(&:to_i)
  end
end

def area(w, h, l)
  (2 * w * h) + (2 * w * l) + (2 * h * l) + [w * h, w * l, h * l].min
end

def total_area
  boxes.map do |edges|
    area(*edges)
  end.inject(:+)
end

puts "Wrapping paper: #{total_area} sqft"

def length(w, h, l)
  smallest = [w, h, l].sort.take(2)
  wrapping = smallest.map { |edge| edge * 2 }.inject(:+)
  bow = w * h * l

  wrapping + bow
end

def total_length
  boxes.map do |edges|
    length(*edges)
  end.inject(:+)
end

puts "Ribbon: #{total_length} ft"
