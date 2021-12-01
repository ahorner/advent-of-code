STEPS = INPUT.chars

final_floor = STEPS.count("(") - STEPS.count(")")
solve!("Final floor:", final_floor)

def first_step(target)
  floor = 0

  STEPS.each_with_index do |step, index|
    floor += (step == "(" ? 1 : -1)
    break index + 1 if floor == target
  end
end

solve!("First basement step:", first_step(-1))
