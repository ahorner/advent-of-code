LINE_MATCHER = /\A\s*(\d+)\s+(\d+)\s+(\d+)\z/.freeze

def valid?(sides)
  maximum = sides.max
  others = sides.dup

  others.delete_at(sides.index(maximum))
  others.inject(:+) > maximum
end

def parse_lines
  INPUT.split("\n").each do |line|
    sides = line.match(LINE_MATCHER).captures
    yield sides.map(&:to_i)
  end
end

valid_count = 0
parse_lines { |sides| valid_count += 1 if valid?(sides) }

puts "There are #{valid_count} valid normal triangles"

rows = []
parse_lines { |sides| rows << sides }
triangles = rows.each_slice(3).flat_map { |items| items.inject(&:zip).map(&:flatten) }
valid_count = triangles.count { |triangle| valid?(triangle) }

puts "There are #{valid_count} valid vertically-assembled triangles"
