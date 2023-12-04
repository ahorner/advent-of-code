GAME_MATCHER = /\AGame (?<id>\d+): (?<hands>.+)\z/
HOLD_MATCHER = /(?<count>\d+) (?<color>\w+)/
COLORS = %i[red green blue].freeze

Game = Data.define(:id, :hands) do
  def possible?(test)
    hands.all? do |hand|
      COLORS.all? { |color| hand[color] <= test[color] }
    end
  end

  def power
    COLORS.map { |color| hands.map { |h| h[color] }.max }.reduce(:*)
  end
end

GAMES = INPUT.split("\n").map do |line|
  data = line.match(GAME_MATCHER)
  id = data[:id].to_i
  hands = data[:hands].split(";").map do |hand|
    hand.split(",").each_with_object(Hash.new(0)) do |item, colors|
      hold = item.match(HOLD_MATCHER)
      colors[hold[:color].to_sym] = hold[:count].to_i
    end
  end

  Game.new(id:, hands:)
end.freeze

TEST = {red: 12, green: 13, blue: 14}.freeze
possibilities = GAMES.select { |g| g.possible?(TEST) }

solve!("The sum of possible game IDs is:", possibilities.sum(&:id))
solve!("The total set power across games is:", GAMES.sum(&:power))
