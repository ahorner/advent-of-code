class KnotHash

  MAGIC_NUMBERS = [17, 31, 73, 47, 23].freeze

  def initialize(input)
    @lengths = input.bytes + MAGIC_NUMBERS
  end

  def hash
    tie_knot(64).each_slice(16).map do |block|
      format("%02x", block.inject(:"^"))
    end.join
  end

  private

  def tie_knot(rounds = 1)
    list = (0..255).to_a
    skip = 0
    rotations = 0

    rounds.times do
      @lengths.each do |length|
        list[0...length] = list[0...length].reverse

        list = list.rotate(length + skip)
        rotations += length + skip
        skip += 1
      end
    end

    list.rotate(-rotations)
  end

end

GRID_SIZE = 128

def hash_row(row)
  KnotHash.new("#{INPUT}-#{row}").hash.hex.to_s(2).rjust(GRID_SIZE, "0").split("")
end

MAP = (0...GRID_SIZE).each_with_object({}) do |i, grid|
  hash_row(i).each_with_index { |c, j| grid[[i, j]] = c }
end.freeze

used = MAP.values.count("1")
puts "The number of used squares is:", used, nil

def group_members(x, y, members = [])
  [
    [x, y + 1],
    [x + 1, y],
    [x, y - 1],
    [x - 1, y],
  ].each do |i, j|
    next unless MAP[[i, j]] == "1"
    next if members.include?([i, j])
    members = group_members(i, j, members + [[i, j]])
  end

  members
end

regions = {}
region_count = 0

MAP.each do |(x, y), c|
  if c == "1" && !regions[[x, y]]
    region_count += 1
    regions[[x, y]] = region_count
    group_members(x, y).each { |i, j| regions[[i, j]] = region_count }
  end
end

puts "The number of distinct regions is:", region_count
