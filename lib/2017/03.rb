require "set"

def grid_to(input, &value_for)
  grid = { [0, 0] => 1 }
  current = { x: 0, y: 0 }
  used = {
    min: { x: 0, y: 0 },
    max: { x: 0, y: 0 },
  }

  value = 1
  direction = :x
  move = 1

  while value <= input
    current[direction] = current[direction] + move

    if (move < 0 && used[:min][direction] > current[direction]) ||
       (move > 0 && used[:max][direction] < current[direction])
      type = move < 0 ? :min : :max
      used[type][direction] = current[direction]

      direction, move =
        case [direction, move]
        when [:x, 1] then [:y, -1]
        when [:y, -1] then [:x, -1]
        when [:x, -1] then [:y, 1]
        when [:y, 1] then [:x, 1]
        end
    end

    value = value_for.call(value, grid, current[:x], current[:y])
    grid[[current[:x], current[:y]]] = value
  end

  grid
end

def distance(input)
  grid_to(input) { |last| last + 1 }.key(input).map(&:abs).inject(:+)
end

def above(input)
  grid_to(input) do |_, grid, x, y|
    grid[[x - 1, y]].to_i +
      grid[[x + 1, y]].to_i +
      grid[[x, y - 1]].to_i +
      grid[[x, y + 1]].to_i +
      grid[[x - 1, y - 1]].to_i +
      grid[[x - 1, y + 1]].to_i +
      grid[[x + 1, y - 1]].to_i +
      grid[[x + 1, y + 1]].to_i
  end.values.last
end

puts "The Manhattan distance from 1 to #{INPUT} is:", distance(INPUT.to_i), nil
puts "The first number above #{INPUT} is:", above(INPUT.to_i)
