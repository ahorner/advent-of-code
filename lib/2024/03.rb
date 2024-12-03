MUL_MATCHER = /mul\((\d+),(\d+)\)/
DO_MATCHER = /do\(\)/
DONT_MATCHER = /don't\(\)/
COMMAND_MATCHER = /(#{MUL_MATCHER}|#{DO_MATCHER}|#{DONT_MATCHER})/

solve!(
  "The sum of `mul` instruction values is:",
  INPUT.scan(MUL_MATCHER).sum { |a, b| a.to_i * b.to_i }
)

def scan(input)
  enable = true
  enabled = input.scan(COMMAND_MATCHER).filter_map do |match,|
    case match
    when MUL_MATCHER
      match.scan(MUL_MATCHER)[0] if enable
    when DO_MATCHER
      enable = true
      nil
    when DONT_MATCHER
      enable = false
      nil
    end
  end

  enabled.sum { |a, b| a.to_i * b.to_i }
end

solve!("The sum of only enabled `mul` instruction values is:", scan(input))
