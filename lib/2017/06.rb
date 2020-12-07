BLOCKS = INPUT.split(/\s+/).map(&:to_i)

blocks = BLOCKS.dup
seen_states = {}
count = 0

until seen_states.key?(blocks)
  seen_states[blocks.dup] = count

  cursor = blocks.index(blocks.max)
  remaining = blocks[cursor]
  blocks[cursor] = 0

  while remaining > 0
    cursor += 1
    remaining -= 1
    blocks[cursor % blocks.length] += 1
  end

  count += 1
end

solve!("The number of cycles required to find an optimal balance is:", count)
solve!("The number of cycles between optimal states is:", count - seen_states[blocks])
