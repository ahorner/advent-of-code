# NOTE: I wanted to write an ALU class, but since this problem is set up to
# rely on extremely specific details of the input, and the problem space as
# defined is basically impossible to brute-force, there's no point.
#
# You _could_ write something to detect the underlying behavior and identify
# pairs dynamically by testing the effect of various digit combinations on the
# magnitude of the final output, but that sounds like a lot of work when we
# already know what the input does.
#
# Instead, I've just hard-coded something to run through the input handler
# chunks, detecting whether the chunk describes a "head" or a "tail" input, and
# pushing and popping indices to create matched pairs as a result. I'm assuming
# that other inputs have the same characteristics, but different values.

HANDLERS = INPUT.split("inp w\n").drop(1).freeze
DIVISOR_MATCHER = /^div z (?<divisor>\d+)$/
HEAD_MATCHER = /\Aadd y -?\d+\z/
TAIL_MATCHER = /\Aadd x -?\d+\z/

PAIRS = begin
  pairs = {}
  heads = []

  HANDLERS.each_with_index do |handler, i|
    divisor = handler.match(DIVISOR_MATCHER)[:divisor].to_i
    lines = handler.split("\n")

    case divisor
    when 1
      head = lines.grep(HEAD_MATCHER).last
      head_diff = head.split.last.to_i

      heads << [i, head_diff]
    else
      tail = lines.grep(TAIL_MATCHER).first
      tail_diff = tail.split.last.to_i

      head, head_diff = heads.pop
      pairs[[head, i]] = head_diff + tail_diff
    end
  end

  pairs
end.freeze

def max_for(pairs)
  pairs.each_with_object(Array.new(pairs.length * 2)) do |((i, j), diff), value|
    value[i] = (diff < 0) ? 9 : 9 - diff
    value[j] = (diff < 0) ? 9 + diff : 9
  end.join
end

def min_for(pairs)
  pairs.each_with_object(Array.new(pairs.length * 2)) do |((i, j), diff), value|
    value[i] = (diff < 0) ? 1 - diff : 1
    value[j] = (diff < 0) ? 1 : 1 + diff
  end.join
end

solve!("The largest accepted model number is:", max_for(pairs))
solve!("The smallest accepted model number is:", min_for(pairs))
