CUCUMBERS = INPUT.split("\n").map(&:chars).freeze
HEIGHT = CUCUMBERS.size
WIDTH = CUCUMBERS[0].size

HERDS = %w[> v].freeze
EMPTY = ".".freeze
MOVEMENTS = {">" => [1, 0], "v" => [0, 1]}.freeze

def step(cucumbers)
  HERDS.each_with_object(Array.new(HEIGHT) { Array.new(WIDTH) { "." } }) do |herd, updated|
    cucumbers.each_with_index do |row, y|
      row.each_with_index do |cucumber, x|
        next unless cucumber == herd

        dx, dy = MOVEMENTS[cucumber]
        nx = (x + dx) % WIDTH
        ny = (y + dy) % HEIGHT

        move = (herd == ">") ? cucumbers[ny][nx] == "." : cucumbers[ny][nx] != herd && updated[ny][nx] == "."

        fx, fy = move ? [nx, ny] : [x, y]
        updated[fy][fx] = cucumber
      end
    end
  end
end

cucumbers = CUCUMBERS
steps = 0

loop do
  steps += 1
  updated = step(cucumbers)
  break steps if cucumbers == updated

  cucumbers = updated
end

solve!("The first step on which no sea cucumbers move is:", steps)
