POSITIONS = INPUT.split(",").map(&:to_i).freeze
RANGE = Range.new(*POSITIONS.minmax)

def fuel_needed(position, increasing: false)
  POSITIONS.sum do |i|
    fuel = (i - position).abs
    increasing ? fuel * (fuel + 1) / 2 : fuel
  end
end

align_on = RANGE.map { |i| fuel_needed(i) }.min
solve!("The minimum fuel needed for alignment is:", align_on)

align_on = RANGE.map { |i| fuel_needed(i, increasing: true) }.min
solve!("The minimum (increasing) fuel needed for alignment is:", align_on)
