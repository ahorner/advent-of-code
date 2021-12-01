require "set"

PASS_MATCHER = /^(?<row>[FB]{7})(?<column>[LR]{3})$/.freeze

def seat_id(boarding_pass)
  row = boarding_pass[:row].tr("FB", "01").to_i(2)
  column = boarding_pass[:column].tr("LR", "01").to_i(2)

  (row * 8) + column
end

PASSES = INPUT.split("\n").each_with_object(Set.new) do |pass, seat_ids|
  seat_ids << seat_id(pass.match(PASS_MATCHER))
end

solve!("The maximum seat ID in the list is:", PASSES.max)

def my_seat?(seat)
  PASSES.include?(seat - 1) && PASSES.include?(seat + 1)
end

MISSING_PASSES = Set.new(1...PASSES.max).subtract(PASSES)
solve!("Your seat ID is:", MISSING_PASSES.detect { |seat| my_seat?(seat) })
