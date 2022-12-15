require "set"

OUTER_BAG_MATCHER = /^(?<color>.+) bags contain (?<contents>.+)\.$/
EMPTY_BAG_MATCHER = /^no other bags$/
INNER_BAG_MATCHER = /^(?<count>\d+) (?<color>.+) bags?/

STARTING_BAG = "shiny gold".freeze

class Bag
  attr_reader :color, :contents

  def initialize(color)
    @color = color
    @contents = {}
  end

  def holds!(color, count)
    @contents[color] = count
  end

  def holds?(contents)
    case contents
    when Bag then @contents.key?(contents.color)
    when String then @contents.key?(contents)
    when Array then contents.any? { |bag| holds?(bag) }
    else false
    end
  end

  def empty?
    @contents.empty?
  end
end

BAGS = INPUT.split("\n").each_with_object({}) do |line, bags|
  description = line.match(OUTER_BAG_MATCHER)
  color = description[:color]
  bags[color] = Bag.new(color)

  next if description[:contents].match?(EMPTY_BAG_MATCHER)

  description[:contents].split(", ").each do |bag|
    inner_bag = bag.match(INNER_BAG_MATCHER)
    bags[color].holds!(inner_bag[:color], inner_bag[:count].to_i)
  end
end

def valid_containers(starting_bag)
  containers = Set.new
  new_bags = [starting_bag]

  loop do
    new_bags = BAGS.values.select { |bag| bag.holds?(new_bags) }
    break if new_bags.empty?

    containers += new_bags
  end

  containers
end

count = valid_containers(STARTING_BAG).count
solve!("The number of valid outer bags is:", count)

def contents_for(bag, memo = {})
  return memo[bag.color] if memo.key?(bag.color)

  contents = Hash.new(0)
  bag.contents.each do |color, count|
    contents[color] += count
    contents_for(BAGS[color], memo).each do |c, n|
      contents[c] += n * count
    end
  end

  memo[bag.color] = contents
end

count = contents_for(BAGS[STARTING_BAG]).values.sum
solve!("The total number of bags in our bag is:", count)
