CHOICE_VALUES_MOVE_BASED =  Hash["A" => :rock, "B" => :paper, "C" => :scissors, "X" => :rock, "Y" => :paper, "Z" => :scissors ].freeze
CHOICE_VALUES_OUTCOME_BASED =  Hash["A" => :rock, "B" => :paper, "C" => :scissors, "X" => :lose, "Y" => :draw, "Z" => :win ].freeze

SHAPE_VALUES = Hash[:rock => 1, :paper => 2, :scissors => 3]
ROUNDS = INPUT.split("\n").map { |rows| rows.split }.freeze

def shape_score(rounds)
  rounds.map { |round| round.map { |choice| CHOICE_VALUES_MOVE_BASED[choice] }}
    .map{ |round| SHAPE_VALUES[round[1]] }.sum
end

def shape_score_outcome_based(rounds)
  rounds.map { |round| round.map { |choice| CHOICE_VALUES_OUTCOME_BASED[choice] }}
        .map do |round|
    if round[1] == :draw
      SHAPE_VALUES[round[0]]
    elsif round[0] == :rock && round[1] == :win
      SHAPE_VALUES[:paper]
    elsif round[0] == :paper && round[1] == :win
      SHAPE_VALUES[:scissors]
    elsif round[0] == :scissors && round[1] == :win
      SHAPE_VALUES[:rock]
    elsif round[0] == :rock && round[1] == :lose
      SHAPE_VALUES[:scissors]
    elsif round[0] == :paper && round[1] == :lose
      SHAPE_VALUES[:rock]
    elsif round[0] == :scissors && round[1] == :lose
      SHAPE_VALUES[:paper]
    end
  end.sum
end
def winner_score(rounds, strategy)
  rounds.map { |round| round.map { |choice| strategy[choice] }}
    .map { |r|
    if r[0] == r[1]
      3
    elsif (r[0] == :rock && r[1] == :paper) || (r[0] == :paper && r[1] == :scissors) || (r[0] == :scissors && r[1] == :rock)
      6
    else
      0
    end
      }.sum
end

def winner_score_outcome_based(rounds)
  rounds.map { |round| round.map { |choice| CHOICE_VALUES_OUTCOME_BASED[choice] }}
    .map { |r|
    if r[1] == :win
      6
    elsif r[1] == :draw
      3
    else
      0
    end
        }.sum
end

solve!(
  "Total score according to moves-based strategy guide is:",
  shape_score(ROUNDS) + winner_score(ROUNDS, CHOICE_VALUES_MOVE_BASED)
)

solve!(
  "Total score according to outcome-based strategy guide is:",
  shape_score_outcome_based(ROUNDS) + winner_score_outcome_based(ROUNDS)
)


