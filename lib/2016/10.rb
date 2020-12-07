class Node
  def initialize
    @sources = {}
  end

  def give(value)
    assign(nil, value)
  end

  def assign(source, method)
    @sources[source] ||= []
    @sources[source] << method
  end

  def values
    @values ||= @sources.flat_map do |source, methods|
      methods.map { |method| source ? source.send(method) : method }
    end.sort
  end

  def low
    values.first
  end

  def high
    values.last
  end
end

GRANT_PATTERN = /value (?<value>\d+) goes to (?<bot>bot \d+)/.freeze
ASSIGN_PATTERN = /(?<bot>bot \d+) gives low to (?<low_output>.+ \d+) and high to (?<high_output>.+ \d+)/.freeze
TARGET_VALUES ||= [17, 61].freeze
TARGET_NODES = ["output 0", "output 1", "output 2"].freeze

nodes = Hash.new { |h, k| h[k] = Node.new }

INPUT.split("\n").each do |line|
  case line
  when GRANT_PATTERN
    matches = line.match(GRANT_PATTERN)
    nodes[matches[:bot]].give(matches[:value].to_i)
  when ASSIGN_PATTERN
    matches = line.match(ASSIGN_PATTERN)
    nodes[matches[:low_output]].assign(nodes[matches[:bot]], :low)
    nodes[matches[:high_output]].assign(nodes[matches[:bot]], :high)
  end
end

bot = nodes.keys.find { |id| nodes[id].values == TARGET_VALUES }
solve!("The bot responsible for comparing #{TARGET_VALUES} is:", bot)

product = TARGET_NODES.map { |id| nodes[id].values.first }.inject(:*)
solve!("The product of chip numbers in #{TARGET_NODES} is:", product)
