MAX_DISTANCE = 3

def constellation?(a, b)
  a.zip(b).map { |i, j| (i - j).abs }.sum <= MAX_DISTANCE
end

CONSTELLATIONS = INPUT.split("\n").each_with_object([]) do |line, constellations|
  point = line.split(",").map(&:to_i)
  merges = []

  constellations.each_with_index do |constellation, index|
    merges << constellation if constellation.any? { |p| constellation?(point, p) }
  end

  if merges.empty?
    constellations << [point]
  else
    merges.each { |constellation| constellations.delete(constellation) }
    constellations.push(merges.flatten(1) + [point])
  end
end

puts "The number of distinct constellations is:", CONSTELLATIONS.size
