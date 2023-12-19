WORKFLOW_MATCHER = /\A(?<name>\w+)\{(?<rules>.+)\}\z/
RULE_MATCHER = /\A(?<rating>\w)(?<operation><|>)(?<value>\d+):(?<output>\w+)\z/
RATING_MATCHER = /\A(?<rating>\w)=(?<value>\d+)\z/

ACCEPTANCE_FLOW = "A"
REJECTION_FLOW = "R"
STARTING_FLOW = "in"

Rule = Data.define(:rating, :operation, :value, :output) do
  def passes?(part)
    (operation == "<") ? part[rating] < value : part[rating] > value
  end

  def partition(ratings)
    passed = ratings.dup
    failed = ratings.dup
    range = ratings[rating]

    passed[rating] = (operation == "<") ? range.begin..(value - 1) : (value + 1)..range.end
    failed[rating] = (operation == "<") ? value..range.end : range.begin..value

    [passed, failed]
  end
end

Fallback = Data.define(:output) do
  def passes?(_)
    true
  end
end

Workflow = Data.define(:rules) do
  def output(part)
    rules.detect { |rule| rule.passes?(part) }.output
  end
end

workflows, parts = INPUT.split("\n\n")

WORKFLOWS = workflows.split("\n").each_with_object({}) do |line, flows|
  data = WORKFLOW_MATCHER.match(line)
  rules = data[:rules].split(",").map do |rule|
    rule_data = RULE_MATCHER.match(rule)

    if rule_data
      Rule.new(
        rating: rule_data[:rating],
        operation: rule_data[:operation],
        value: rule_data[:value].to_i,
        output: rule_data[:output]
      )
    else
      Fallback.new(output: rule)
    end
  end

  flows[data[:name]] = Workflow.new(rules:)
end

PARTS = parts.split("\n").map do |part|
  part.tr("{}", "").split(",").each_with_object({}) do |rating, ratings|
    rating_data = RATING_MATCHER.match(rating)
    ratings[rating_data[:rating]] = rating_data[:value].to_i
  end
end

def accepted?(part)
  flow = STARTING_FLOW

  loop do
    flow = WORKFLOWS[flow].output(part)

    break true if flow == ACCEPTANCE_FLOW
    break false if flow == REJECTION_FLOW
  end
end

accepted = PARTS.select { |part| accepted?(part) }
solve!("The sum of acceptable parts' ratings is:", accepted.sum { |part| part.values.sum })

def valid_combinations(ratings, flow = STARTING_FLOW)
  sizes = ratings.values.map(&:size)

  return 0 if flow == REJECTION_FLOW || sizes.any?(&:zero?)
  return sizes.reduce(:*) if flow == ACCEPTANCE_FLOW

  WORKFLOWS[flow].rules.sum do |rule|
    if rule.is_a?(Fallback)
      valid_combinations(ratings, rule.output)
    else
      passed, ratings = rule.partition(ratings)
      valid_combinations(passed, rule.output)
    end
  end
end

RANGES = {"x" => 1..4000, "m" => 1..4000, "a" => 1..4000, "s" => 1..4000}
solve!("The total number of valid combinations is:", valid_combinations(RANGES))
