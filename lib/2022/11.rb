class Monkey
  PATTERN = Regexp.new(<<~REGEXP.strip)
    Monkey (?<id>\\d+):
      Starting items: (?<items>[0-9 ,]+)
      Operation: new = old (?<operator>.) (?<value>.+)
      Test: divisible by (?<test>\\d+)
        If true: throw to monkey (?<pass>\\d+)
        If false: throw to monkey (?<fail>\\d+)
  REGEXP

  attr_reader :id, :inspections, :test

  def initialize(definition)
    data = PATTERN.match(definition)

    @id = data[:id].to_i
    @items = data[:items].split(", ").map(&:to_i)
    @operation = {
      operator: data[:operator].to_sym,
      value: data[:value],
    }

    @test = data[:test].to_i
    @pass = data[:pass].to_i
    @fail = data[:fail].to_i

    @inspections = 0
  end

  def inspect!(limiter = nil)
    loop do
      break if @items.empty?

      @inspections += 1
      item = @items.pop

      value = @operation[:value]
      value = value == "old" ? item : value.to_i

      item =
        case @operation[:operator]
        when :+ then (item + value)
        when :* then (item * value)
        end

      if limiter
        item %= limiter
      else
        item /= 3
      end

      result = item % @test == 0
      yield item, (result ? @pass : @fail)
    end
  end

  def catch!(item)
    @items << item
  end

  def dup
    Marshal.load(Marshal.dump(self))
  end
end

MONKEYS = INPUT.split("\n\n").each_with_object({}) do |definition, monkeys|
  monkey = Monkey.new(definition)
  monkeys[monkey.id] = monkey
end.freeze

def monkey_business(rounds, limiter = nil)
  monkeys = MONKEYS.transform_values(&:dup)

  rounds.times do
    monkeys.each do |_, monkey|
      monkey.inspect!(limiter) do |item, recipient|
        monkeys[recipient].catch!(item)
      end
    end
  end

  active = monkeys.values.max_by(2, &:inspections)
  active.map(&:inspections).reduce(:*)
end

solve!(
  "The level of monkey business is:",
  monkey_business(20),
)

# We can reset the worry level of an item via modulo when it exceeds
# a value that's perfectly divisible by all monkeys' tests.
LIMITER = MONKEYS.values.map(&:test).reduce(:*)
solve!(
  "The level of very worrisome monkey business is:",
  monkey_business(10_000, LIMITER),
)
