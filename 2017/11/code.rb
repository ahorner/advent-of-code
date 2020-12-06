MOVEMENTS = INPUT.split(",")

def distance(x, y, z)
  (x.abs + y.abs + z.abs) / 2
end

x = 0
y = 0
z = 0
max = 0

MOVEMENTS.each do |movement|
  motion =
    case movement
    when "n" then [0, 1, -1]
    when "ne" then [1, 0, -1]
    when "se" then [1, -1, 0]
    when "s" then [0, -1, 1]
    when "sw" then [-1, 0, 1]
    when "nw" then [-1, 1, 0]
    end

  x, y, z = [x, y, z].zip(motion).map { |c1, c2| c1 + c2 }
  max = [max, distance(x, y, z)].max
end

puts "The distance to the child's final tile is:", distance(x, y, z), nil
puts "The furthest distance at any point was:", max
