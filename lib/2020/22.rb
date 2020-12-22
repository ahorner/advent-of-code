require "set"

DECKS = INPUT.scan(/Player \d+:\n([\d\n]+)/).map { |(deck)| deck.split("\n").map(&:to_i) }.freeze

def combat(decks, recursive: false)
  rounds = Set.new

  loop do
    break [0, decks[0]] if rounds.include?(decks.hash)

    rounds << decks.hash
    cards = decks.map(&:shift)

    if recursive && decks.each_index.all? { |i| decks[i].size >= cards[i] }
      winner, = combat(decks.map.with_index { |deck, i| deck.take(cards[i]) }, recursive: true)
      loser = (winner + 1) % decks.size
    else
      winner, loser = cards.each_with_index.sort_by(&:first).reverse.map(&:last)
    end

    decks[winner] += cards.values_at(winner, loser)
    break [winner, decks[winner]] if decks[loser].empty?
  end
end

def score_for(deck)
  deck.each_index.sum { |i| deck[i] * (deck.size - i) }
end

_, deck = combat(DECKS.map(&:dup))
solve!("The winning score after combat is:", score_for(deck))

_, deck = combat(DECKS.map(&:dup), recursive: true)
solve!("The winning score after recursive combat is:", score_for(deck))
