LIST_SIZE ||= 256

def tie_knot(lengths, rounds = 1)
  list = (0...LIST_SIZE).to_a
  skip = 0
  rotations = 0

  rounds.times do
    lengths.each do |length|
      list[0...length] = list[0...length].reverse

      list = list.rotate(length + skip)
      rotations += length + skip
      skip += 1
    end
  end

  list.rotate(-rotations)
end

result = tie_knot(INPUT.split(",").map(&:to_i))
knot_value = result[0] * result[1]

solve!("The check value of the knot is:", knot_value)

MAGIC_NUMBERS = [17, 31, 73, 47, 23].freeze
result = tie_knot(INPUT.bytes + MAGIC_NUMBERS, 64)
knot_hash = result.each_slice(16).map { |block| format("%02x", block.inject(:"^")) }.join

solve!("The Knot Hash for the input is:", knot_hash)
