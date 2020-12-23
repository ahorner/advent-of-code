LABELS = INPUT.split("").map(&:to_i).freeze

class Cup
  attr_reader :label
  attr_accessor :next

  def initialize(label)
    @label = label
    @next = self
  end

  def insert!(cup)
    cup.next = @next
    @next = cup
  end
end

def move!(cups, current)
  taken = [current.next, current.next.next, current.next.next.next]
  current.next = taken[-1].next

  target = current.label

  loop do
    target = target == 1 ? cups.count : target - 1
    break if taken.none? { |cup| cup.label == target }
  end

  taken[-1].next = cups[target].next
  cups[target].next = taken[0]
end

def play(labels, moves)
  current = nil
  cups = labels.each_with_object({}) do |label, cups|
    cups[label] = Cup.new(label)

    current&.insert!(cups[label])
    current = cups[label]
  end

  moves.times { move!(cups, current = current.next) }

  cups
end

result = play(LABELS, 100)

current = result[1]
labels = (result.count - 1).times.map { (current = current.next).label }
solve!("The labels clockwise from 1 after 100 rounds are:", labels.join)

new_labels = LABELS + ((LABELS.count + 1)..1_000_000).to_a
result = play(new_labels, 10_000_000)

product = result[1].next.label * result[1].next.next.label
solve!("The product of the two labels clockwise from 1 is:", product)
