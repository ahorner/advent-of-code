TREES = INPUT.split("\n").map { |row| row.chars.map(&:to_i) }
DIRECTIONS = [[0, 1], [1, 0], [0, -1], [-1, 0]].freeze

HEIGHT = TREES.length
WIDTH = TREES.first.length

COORDS = (0...WIDTH).to_a.product((0...HEIGHT).to_a)

def path_for(x, y, (dx, dy))
  Enumerator.new do |enum|
    loop do
      x += dx
      y += dy

      break if x < 0 || y < 0 || x >= width || y >= height

      enum.yield [x, y]
    end
  end
end

def visible?(x, y)
  height = TREES[y][x]

  DIRECTIONS.any? do |dir|
    path_for(x, y, dir).none? { |i, j| TREES[j][i] >= height }
  end
end

solve!(COORDS.count { |x, y| visible?(x, y) })

def scenic_score(x, y)
  height = TREES[y][x]

  DIRECTIONS.reduce(1) do |score, dir|
    count = path_for(x, y, dir).reduce(0) do |count, (i, j)|
      TREES[i][j] >= height ? (break count + 1) : count + 1
    end

    score * count
  end
end

solve!(COORDS.map { |x, y| scenic_score(x, y) }.max)
