OPERATION_MATCHERS = {
  cut: /\Acut (?<count>.+)\z/,
  deal: /\Adeal with increment (?<count>.+)\z/,
  flip: /\Adeal into new stack\z/
}.freeze

OPERATIONS = INPUT.split("\n").map do |operation|
  case operation
  when OPERATION_MATCHERS[:cut] then [:cut, $~[:count].to_i]
  when OPERATION_MATCHERS[:deal] then [:deal, $~[:count].to_i]
  when OPERATION_MATCHERS[:flip] then [:flip]
  end
end

class Deck
  def initialize(size, shuffler)
    @size = size
    @shuffler = simplify(shuffler)
  end

  def shuffle
    cards = (0...@size).to_a

    @shuffler.each do |operation, argument|
      cards =
        case operation
        when :cut then cards.rotate(argument)
        when :deal then cards.each_index.map { |i| cards[(i * modular_inverse(argument)) % @size] }
        when :flip then cards.reverse
        end
    end

    cards
  end

  def card_at(position, shuffles: 1)
    phases = {}
    power = 1
    operations = @shuffler

    until power > shuffles
      phases[power] = simplify(operations)
      power <<= 1
      operations = simplify(operations + operations)
    end

    operations = phases.flat_map { |power, ops| (shuffles & power == 0) ? [] : ops }
    simplify(operations).reverse_each do |operation, argument|
      position =
        case operation
        when :cut then (position + argument) % @size
        when :deal then (position * modular_inverse(argument)) % @size
        when :flip then @size - 1 - position
        end
    end

    position
  end

  private

  def simplify(operations)
    steps = operations.dup

    loop do
      steps.each_index do |i|
        next unless steps[i] && steps[i + 1]

        first_op, first_arg = steps[i]
        second_op, second_arg = steps[i + 1]

        steps[i, 2] =
          case [first_op, second_op]
          when %i[cut cut] then [[:cut, (first_arg + second_arg) % @size]]
          when %i[cut deal] then [[:deal, second_arg], [:cut, (first_arg * second_arg) % @size]]
          when %i[deal deal] then [[:deal, (first_arg * second_arg) % @size]]
          when %i[flip cut] then [[:cut, -second_arg], [:flip]]
          when %i[flip deal] then [[:deal, second_arg], [:cut, -second_arg + 1], [:flip]]
          when %i[flip flip] then []
          else steps[i, 2]
          end
      end

      step_names = steps.map(&:first)
      break steps if step_names.uniq == step_names
    end
  end

  # Apologies to: https://rosettacode.org/wiki/Modular_inverse#Ruby
  def modular_inverse(value)
    n = @size
    inverse = 1
    x = 0

    while value > 1
      inverse -= (value / n) * x
      value, n = n, value % n
      inverse, x = x, inverse
    end

    inverse % @size
  end
end

deck = Deck.new(10_007, OPERATIONS)
cards = deck.shuffle

solve!("The position of card 2019 after shuffling is:", cards.index(2019))

deck = Deck.new(119_315_717_514_047, OPERATIONS)
card = deck.card_at(2020, shuffles: 101_741_582_076_661)

solve!("The card at position 2020 after shuffling is:", card)
