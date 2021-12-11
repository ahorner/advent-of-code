OCTOPODES = INPUT.split("\n").map { |row| row.chars.map(&:to_i) }.freeze
NEIGHBORS = ([-1, 0, 1].product([-1, 0, 1]) - [0, 0]).freeze
FLASH_THRESHOLD = 10
STEPS = 100

def flash(octopodes, x, y)
  NEIGHBORS.each do |dx, dy|
    nx = x + dx
    ny = y + dy

    next if ny < 0 || ny >= octopodes.size
    next if nx < 0 || nx >= octopodes[y].size

    octopodes[ny][nx] += 1
    flash(octopodes, nx, ny) if octopodes[ny][nx] == FLASH_THRESHOLD
  end
end

def step(octopodes)
  octopodes = octopodes.map(&:dup)

  octopodes.each_index do |y|
    octopodes[y].each_index do |x|
      octopodes[y][x] += 1
      flash(octopodes, x, y) if octopodes[y][x] == FLASH_THRESHOLD
    end
  end

  flashes = octopodes.each_index.sum do |y|
    octopodes[y].each_index.count do |x|
      next false if octopodes[y][x] < FLASH_THRESHOLD

      octopodes[y][x] = 0
    end
  end

  [flashes, octopodes]
end

octopodes = OCTOPODES
flash_count = STEPS.times.sum do
  flashes, octopodes = step(octopodes)
  flashes
end

solve!("The total number of flashes in 100 steps is:", flash_count)

step_number = 0
octopodes = OCTOPODES

loop do
  step_number += 1
  flashes, octopodes = step(octopodes)

  break step_number if flashes == octopodes.size * octopodes[0].size
end

solve!("The first step where the octopodes synchronize is:", step_number)
