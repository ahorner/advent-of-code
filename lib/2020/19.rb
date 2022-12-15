RULE_MATCHER = /^(\d+): (.+)$/
MESSAGES = INPUT.scan(/^\w+$/).freeze

class RuleSet
  CHAR_MATCHER = /\A"(?<chars>\w+)"\z/

  attr_reader :rules

  def initialize(patterns)
    @patterns = patterns
    @rules = {}
  end

  def match?(message)
    message.match?(/\A#{self["0"]}\z/)
  end

  def [](index)
    return rules[index] if rules[index]

    pattern = @patterns[index]
    rules[index] =
      case pattern
      when CHAR_MATCHER
        $~[:chars]
      else
        pattern = pattern.scan(/\d+/).reduce(pattern) { |r, t| r.gsub(/\b#{t}\b/, self[t]) }
        "(#{pattern.delete(" ")})"
      end
  end
end

RULESET = RuleSet.new(INPUT.scan(RULE_MATCHER).to_h)
solve!("The number of matching messages is:", MESSAGES.count { |message| RULESET.match?(message) })

RULESET.rules["8"] = "(#{RULESET["42"]}+)" # 8: 42 | 42 8
RULESET.rules["11"] = "(?<l>#{RULESET["42"]}\\g<l>?#{RULESET["31"]})" # 11: 42 31 | 42 11 31
RULESET.rules["0"] = nil

solve!("The number of matching looped messages is:", MESSAGES.count { |message| RULESET.match?(message) })
