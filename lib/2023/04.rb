Card = Data.define(:id, :winning_numbers, :personal_numbers) do
  def matches
    (winning_numbers & personal_numbers).count
  end

  def score
    (matches > 0) ? (matches - 1).times.reduce(1) { |i, _| i * 2 } : 0
  end
end

CARDS = INPUT.split("\n").map do |line|
  identifier, numbers = line.split(":")
  winning, personal = numbers.split("|")

  Card.new(
    id: identifier.scan(/\d+/).first.to_i,
    winning_numbers: winning.scan(/\d+/).map(&:to_i),
    personal_numbers: personal.scan(/\d+/).map(&:to_i)
  )
end

solve!("The total point value of your cards is:", CARDS.sum(&:score))

def winnings(cards)
  counts = cards.to_h { |card| [card.id, 1] }
  cards.each do |card|
    card.matches.times do |i|
      counts[card.id + i + 1] += counts[card.id]
    end
  end

  counts.values.sum
end

solve!("The total number of cards in the pile (including copies) is:", winnings(CARDS))
