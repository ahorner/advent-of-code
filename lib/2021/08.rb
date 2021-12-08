ENTRIES = INPUT.split("\n").map do |line|
  input, output = line.split(" | ")

  [
    input.split.map(&:chars).map(&:sort),
    output.split.map(&:chars).map(&:sort),
  ]
end

AVAILABLE_SEGMENTS = %w[a b c d e f g].freeze
SEGMENT_MAPPINGS = {
  0 => %w[a b c e f g],
  1 => %w[c f],
  2 => %w[a c d e g],
  3 => %w[a c d f g],
  4 => %w[b c d f],
  5 => %w[a b d f g],
  6 => %w[a b d e f g],
  7 => %w[a c f],
  8 => %w[a b c d e f g],
  9 => %w[a b c d f g],
}.freeze

UNIQUE_DIGITS = [1, 4, 7, 8].freeze

unique_counts = UNIQUE_DIGITS.map { |digit| SEGMENT_MAPPINGS[digit].size }
digit_count = ENTRIES.sum do |(_input, output)|
  output.count { |word| unique_counts.include?(word.size) }
end

solve!("The count of unique digits is:", digit_count)

final = ENTRIES.sum do |inputs, outputs|
  inputs = inputs.uniq
  patterns = {
    1 => inputs.detect { |i| i.size == 2 },
    4 => inputs.detect { |i| i.size == 4 },
    7 => inputs.detect { |i| i.size == 3 },
    8 => inputs.detect { |i| i.size == 7 },
  }

  patterns[9] = inputs.detect { |i| i.size == 6 && (i & patterns[4]).size == 4 }
  patterns[0] = inputs.detect { |i| i.size == 6 && (i & patterns[7]).size == 3 && i != patterns[9] }
  patterns[6] = inputs.detect { |i| i.size == 6 && i != patterns[9] && i != patterns[0] }
  patterns[5] = inputs.detect { |i| i.size == 5 && (i & patterns[6]).size == 5 }
  patterns[3] = inputs.detect { |i| i.size == 5 && (i & patterns[4]).size == 3 && i != patterns[5] }
  patterns[2] = inputs.detect { |i| i.size == 5 && i != patterns[5] && i != patterns[3] }

  outputs.map { |o| patterns.key(o) }.join.to_i
end

solve!("The sum of output values is:", final)
