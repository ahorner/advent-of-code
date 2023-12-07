CARD_SCORES = %w[2 3 4 5 6 7 8 9 T J Q K A].each_with_index.to_h.freeze
JOKER_SCORES = %w[J 2 3 4 5 6 7 8 9 T Q K A].each_with_index.to_h.freeze

Hand = Data.define(:cards) do
  def score
    base_score = cards.tally.values.sort.reverse
    [base_score] + cards.map { |c| CARD_SCORES[c] }
  end

  def joker_score
    counts = cards.tally
    jokers = counts.delete("J") || 0

    base_score = counts.values.sort.reverse
    base_score = [0] if base_score.empty?
    base_score[0] += jokers

    [base_score] + cards.map { |c| JOKER_SCORES[c] }
  end
end

BIDS = INPUT.split("\n").to_h do |line|
  hand, bid = line.split(" ")
  [Hand.new(cards: hand.chars), bid.to_i]
end
HANDS = BIDS.keys

def winnings(hands, bids)
  hands.map.with_index { |h, i| bids[h] * (i + 1) }.sum
end

solve!("The total winnings are:", winnings(HANDS.sort_by(&:score), BIDS))
solve!("The total winnings with jokers are:", winnings(HANDS.sort_by(&:joker_score), BIDS))
