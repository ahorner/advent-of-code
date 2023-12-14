CUBE = "#"
ROUND = "O"
EMPTY = "."

PLATFORM = INPUT.split("\n").map do |(line, y), platform|
  line.chars.map.with_index do |c, x|
    (c == EMPTY) ? nil : c
  end
end

def slide_sequence(width, height, direction)
  case direction
  when [0, -1] then (0...height).each { |y| (0...width).each { |x| yield [x, y] } }
  when [0, 1] then (height - 1).downto(0).each { |y| (0...width).each { |x| yield [x, y] } }
  when [-1, 0] then (0...width).each { |x| (0...height).each { |y| yield [x, y] } }
  when [1, 0] then (width - 1).downto(0).each { |x| (0...height).each { |y| yield [x, y] } }
  end
end

def tilt(platform, (dx, dy))
  tilted = platform.map(&:dup)
  width = platform.size
  height = platform[0].size

  slide_sequence(width, height, [dx, dy]) do |x, y|
    next unless platform[y][x] == ROUND

    i = x
    j = y

    loop do
      break if i + dx < 0 || j + dy < 0 || i + dx >= width || j + dy >= height || tilted[j + dy][i + dx]

      tilted[j + dy][i + dx] = tilted[j][i]
      tilted[j][i] = nil

      i += dx
      j += dy
    end
  end

  tilted
end

def load_for(platform)
  ymax = platform.size
  platform.each_with_index.sum do |row, y|
    row.sum do |r|
      (r == ROUND) ? (ymax - y) : 0
    end
  end
end

solve!("The load after tilting north is:", load_for(tilt(PLATFORM, [0, -1])))

CYCLES = 1000000000

platform = PLATFORM
cache = {}
cycles = 0

final = loop do
  platform = [[0, -1], [-1, 0], [0, 1], [1, 0]].reduce(platform) { |p, d| tilt(p, d) }
  cycles += 1

  if cache[platform]
    loops_at = cache[platform]
    loop_size = cycles - loops_at
    cycle = (CYCLES - loops_at) % loop_size

    break cache.key(loops_at + cycle)
  end

  cache[platform] = cycles
end

solve!("The load after #{CYCLES} cycles is:", load_for(final))
