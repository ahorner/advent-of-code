PLAYER_MATCHER = /\APlayer \d+ starting position: (?<position>\d+)\z/
STARTING_POSITIONS = INPUT.split("\n").map do |line|
  match = line.match(PLAYER_MATCHER)
  match[:position].to_i - 1
end

class Game
  ROLLS = (1..100).to_a

  WINNING_SCORE = 1_000
  POSITION_COUNT = 10
  ROLL_COUNT = 3

  attr_reader :rolls

  def initialize
    @rolls = 0
  end

  def play(positions)
    scores = positions.map { 0 }

    loop do
      positions = positions.map.with_index do |position, i|
        position = (position + roll!) % POSITION_COUNT
        scores[i] += position + 1

        break false if scores[i] >= WINNING_SCORE

        position
      end

      break scores unless positions
    end
  end

  private

  def roll!
    roll = ROLL_COUNT.times.sum { |r| ROLLS[(@rolls + r) % ROLLS.count] }
    @rolls += ROLL_COUNT

    roll
  end
end

class QuantumGame
  SIDES = [1, 2, 3].freeze
  POSSIBILITIES = SIDES.product(SIDES, SIDES).map(&:sum).freeze

  WINNING_SCORE = 21
  POSITION_COUNT = 10

  def initialize
    @universes = {}
  end

  def play(positions, scores = positions.map { 0 }, player = 0)
    @universes[[positions, scores, player]] ||= begin
      winner = scores.any? { |score| score >= WINNING_SCORE }
      return scores.map { |s| (s >= WINNING_SCORE) ? 1 : 0 } if winner # rubocop:disable Lint/NoReturnInBeginEndBlocks

      POSSIBILITIES.map do |roll|
        position = positions[player]
        position = (position + roll) % POSITION_COUNT

        position_quanta = positions.dup
        score_quanta = scores.dup

        position_quanta[player] = position
        score_quanta[player] += position + 1

        play(position_quanta, score_quanta, (player + 1) % positions.count)
      end.transpose.map(&:sum)
    end
  end
end

game = Game.new
scores = game.play(STARTING_POSITIONS)
solve!("The final state of the dice game is:", scores.min * game.rolls)

scores = QuantumGame.new.play(STARTING_POSITIONS)
solve!("The largest number of wins across all universes is:", scores.max)
