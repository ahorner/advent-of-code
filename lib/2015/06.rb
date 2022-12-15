INSTRUCTION_MATCHER = /(?<step>turn off|turn on|toggle) (?<x>\d+),(?<y>\d+) through (?<x2>\d+),(?<y2>\d+)/
INSTRUCTIONS = INPUT.split("\n").map { |line| INSTRUCTION_MATCHER.match(line) }

def for_step(step)
  (step[:x].to_i..step[:x2].to_i).each do |x|
    (step[:y].to_i..step[:y2].to_i).each do |y|
      yield step[:step], x, y
    end
  end
end

def adjust_lights(instruction, lights)
  for_step(instruction) do |step, x, y|
    case step
    when "turn on" then lights[[x, y]] = true
    when "turn off" then lights[[x, y]] = false
    when "toggle" then lights[[x, y]] = !lights[[x, y]]
    end
  end
end

grid = Hash.new(false)
INSTRUCTIONS.each do |line|
  adjust_lights(line, grid)
end

solve!("All of the lights:", grid.values.count(&:itself))

def adjust_brightness(instruction, lights)
  for_step(instruction) do |step, x, y|
    case step
    when "turn on" then lights[[x, y]] += 1
    when "turn off" then lights[[x, y]] = [0, lights[[x, y]] - 1].max
    when "toggle" then lights[[x, y]] += 2
    end
  end
end

grid = Hash.new(0)
INSTRUCTIONS.each do |line|
  adjust_brightness(line, grid)
end

solve!("Required holiday SPF:", grid.values.sum)
