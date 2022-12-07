LINES = INPUT.split("\n").freeze
CHANGE_MATCHER = /\$ cd (?<directory>.+)/.freeze
FILE_MATCHER = /(?<filesize>\d+) (?<filename>.+)/.freeze

sizes = Hash.new(0)
pwd = []

LINES.each do |line|
  case line
  when CHANGE_MATCHER
    dir = $~[:directory]
    dir == ".." ? pwd.pop : pwd << dir
  when FILE_MATCHER
    path = pwd.dup

    loop do
      sizes[path.dup] += $~[:filesize].to_i
      path.pop
      break if path.empty?
    end
  end
end

solve!(
  "The total size of all directories below 100k is:",
  sizes.values.select { |size| size < 100_000 }.sum,
)

TOTAL = 70_000_000
NEEDED = 30_000_000
USABLE = TOTAL - NEEDED

USED = sizes[["/"]]
TARGET = USED - USABLE

solve!(
  "The size of the best directory to remove is:",
  sizes.values.sort.detect { |size| size >= TARGET },
)
