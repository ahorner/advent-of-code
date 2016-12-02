PACKAGES = INPUT.split("\n").map(&:to_i)
TOTAL_WEIGHT = PACKAGES.inject(:+)

def target_subsets(array, sum)
  return [] if array.empty?

  first, *rest = array
  target = sum - first

  if target == 0
    return [[first]]
  elsif target < 0
    return target_subsets(rest, sum)
  else
    subsets = target_subsets(rest, target).map { |subset| [first, *subset] }
    return target_subsets(rest, sum) + subsets
  end
end

def quantum_entanglement(combination)
  combination.inject(:*)
end

def minimal_entanglement(group_weight)
  sets = target_subsets(PACKAGES.reverse, group_weight)

  min_size = sets.min_by(&:size).size
  sets.select { |set| set.size == min_size }.map { |set| quantum_entanglement(set) }.min
end


puts "Optimal QE with good legroom:", minimal_entanglement(TOTAL_WEIGHT/3), nil
puts "Optimal QE with good legroom (and a trunk):", minimal_entanglement(TOTAL_WEIGHT/4)
