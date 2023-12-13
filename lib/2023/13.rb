class Pattern
  def initialize(pattern)
    @horizontal = pattern.split("\n")
    @vertical = pattern.split("\n").map(&:chars).transpose.map(&:join)
  end

  def reflection_score(smudges: 0)
    vertical = (0...@vertical.length).detect { |i| reflects_at?(@vertical, i, smudges:) }
    return vertical + 1 if vertical

    horizontal = (0...@horizontal.length).detect { |i| reflects_at?(@horizontal, i, smudges:) }
    (horizontal + 1) * 100
  end

  def reflects_at?(pattern, row, smudges: 0)
    return false if row == pattern.length - 1

    i = 0
    delta = 0

    loop do
      if pattern[row - i] != pattern[row + i + 1]
        delta += pattern[0].length.times.count { |c| pattern[row - i][c] != pattern[row + i + 1][c] }
        break false if delta > smudges
      end

      i += 1

      break delta == smudges if row - i < 0 || row + i + 1 >= pattern.length
    end
  end
end

PATTERNS = INPUT.split("\n\n").map { |pattern| Pattern.new(pattern) }
solve!("The mirror line score is:", PATTERNS.sum(&:reflection_score))
solve!("The smudge-free mirror line score is:", PATTERNS.sum { |p| p.reflection_score(smudges: 1) })
