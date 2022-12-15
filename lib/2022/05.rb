drawing, procedure = INPUT.split("\n\n")

STACKS =
  drawing.split("\n")[...-1].reverse.map do |row|
    row.chars.each_slice(4).map { |stack| stack[1] }
  end.reduce(:zip).map do |stack|
    stack.flatten.compact.reject { |crate| crate == " " }
  end

STEP_MATCHER = /move (?<count>\d+) from (?<from>\d+) to (?<to>\d+)/
PROCEDURE = procedure.enum_for(:scan, STEP_MATCHER).map { Regexp.last_match }

def rearrange(stacks, step, multiple: false)
  stacks = stacks.map(&:dup)

  moved = stacks[step[:from].to_i - 1].pop(step[:count].to_i)
  moved = moved.reverse unless multiple

  stacks[step[:to].to_i - 1] += moved
  stacks
end

stacks = PROCEDURE.reduce(STACKS) { |result, step| rearrange(result, step) }
solve!(
  "The top crates after rearranging are:",
  stacks.map(&:last).join
)

stacks = PROCEDURE.reduce(STACKS) { |result, step| rearrange(result, step, multiple: true) }
solve!(
  "The top crates after rearranging with the CrateMover 9001 are:",
  stacks.map(&:last).join
)
