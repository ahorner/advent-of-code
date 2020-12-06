MODULES = INPUT.split("\n").map(&:to_i)

def fuel_requirement(mass)
  (mass / 3.0).floor - 2
end

total = MODULES.sum { |mass| fuel_requirement(mass) }
solve!("The total fuel requirement is:", total)

def compounded_fuel_requirement(mass)
  fuel = 0
  fuel += mass = [fuel_requirement(mass), 0].max while mass > 0

  fuel
end

total = MODULES.sum { |mass| compounded_fuel_requirement(mass) }
solve!("The total fuel requirement (with compounding) is:", total)
