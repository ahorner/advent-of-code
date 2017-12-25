START_MATCHER = /Begin in state (?<state>\w)\./
STEPS_MATCHER = /Perform a diagnostic checksum after (?<steps>\d+) steps\./
RULE_MATCHER = /In state (?<state>\w):\n  If the current value is 0:\n    - Write the value (?<zero_value>\d)\.\n    - Move one slot to the (?<zero_direction>\w+)\.\n    - Continue with state (?<zero_state>\w)\.\n  If the current value is 1:\n    - Write the value (?<one_value>\d)\.\n    - Move one slot to the (?<one_direction>\w+)\.\n    - Continue with state (?<one_state>\w)\./

rules = {}
INPUT.scan(RULE_MATCHER) do
  rules[[$~[:state], 0]] = {
    value: $~[:zero_value].to_i,
    move: $~[:zero_direction] == "left" ? -1 : 1,
    state: $~[:zero_state],
  }
  rules[[$~[:state], 1]] = {
    value: $~[:one_value].to_i,
    move: $~[:one_direction] == "left" ? -1 : 1,
    state: $~[:one_state],
  }
end

state = INPUT.match(START_MATCHER)[:state]
steps = INPUT.match(STEPS_MATCHER)[:steps].to_i
cursor = 0
slots = Hash.new(0)

steps.times do
  rule = rules[[state, slots[cursor]]]
  slots[cursor] = rule[:value]
  cursor += rule[:move]
  state = rule[:state]
end

puts "The number of 1s in the checksum is:", slots.values.count(1)
