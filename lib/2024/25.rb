schematics = INPUT.split("\n\n")

SPACE = schematics.first.split("\n").size - 2
SCHEMATICS = schematics.each_with_object({locks: [], keys: []}) do |schematic, combinations|
  rows = schematic.split("\n")
  heights = [-1] * rows.first.size
  rows.each { |r| r.chars.each_with_index { |c, i| heights[i] += 1 if c == "#" } }

  combinations[(rows[0][0] == "#") ? :locks : :keys] << heights
end

def pair?(lock, key)
  lock.zip(key).none? { |l, k| l + k > SPACE }
end

solve!(
  "The number of unique non-overlapping lock/key pairs is:",
  SCHEMATICS[:locks].product(SCHEMATICS[:keys]).count { |lock, key| pair?(lock, key) }
)
