LITERS ||= 150
containers = INPUT.split("\n").map(&:to_i)

combos = (1..containers.length).flat_map do |i|
  containers.combination(i).to_a
end

working = combos.select { |combo| combo.sum == LITERS }

solve!("Working combinations:", working.size)

min_length = working.min_by(&:size).size
matching = working.count { |combo| combo.size == min_length }

solve!("Working combinations with minimal container use:", matching)
