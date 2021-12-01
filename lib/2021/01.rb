SWEEPS = INPUT.split("\n").map(&:to_i)

def increases_for(measurements)
  measurements.each_cons(2).count { |i, j| i < j }
end

solve!("The number of depth increases is:", increases_for(SWEEPS))

window_sums = SWEEPS.each_cons(3).map(&:sum)
solve!("The number of 3-measurement depth increases is:", increases_for(window_sums))
