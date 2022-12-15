MOVEMENTS = INPUT.split(",")
VECTORS = {
  "n" => [0, 1, -1],
  "ne" => [1, 0, -1],
  "se" => [1, -1, 0],
  "s" => [0, -1, 1],
  "sw" => [-1, 0, 1],
  "nw" => [-1, 1, 0]
}.freeze

def distance(x, y, z)
  (x.abs + y.abs + z.abs) / 2
end

x = 0
y = 0
z = 0
max = 0

MOVEMENTS.each do |movement|
  motion = VECTORS[movement]
  x, y, z = [x, y, z].zip(motion).map { |c1, c2| c1 + c2 }
  max = [max, distance(x, y, z)].max
end

solve!("The distance to the child's final tile is:", distance(x, y, z))
solve!("The furthest distance at any point was:", max)
