LIST = INPUT.split("\n").map(&:to_i)

def steps(list)
  cursor = 0
  count = 0

  while cursor >= 0 && cursor < list.length
    current = cursor
    count += 1
    cursor += list[cursor]
    yield list, current
  end

  count
end

count = steps(LIST.dup) do |list, index|
  list[index] += 1
end

solve!("The number of steps to escape is:", count)

count = steps(LIST.dup) do |list, index|
  list[index] += (list[index] >= 3) ? -1 : 1
end

solve!("The number of steps to escape (with decrementing) is:", count)
