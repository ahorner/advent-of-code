def inputs
  INPUT.split("\n")
end

INSTRUCTION_MATCHER = /(?<step>turn off|turn on|toggle) (?<x>\d+),(?<y>\d+) through (?<x2>\d+),(?<y2>\d+)/.freeze

def for_step(instruction)
  step = INSTRUCTION_MATCHER.match(instruction)

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
inputs.each do |line|
  adjust_lights(line, grid)
end

puts "All of the lights:"
puts grid.count { |_, light| !!light }
puts

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
inputs.each do |line|
  adjust_brightness(line, grid)
end

puts "Required holiday SPF:"
puts grid.values.inject(:+)
