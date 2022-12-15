ROUNDS = INPUT.split("\n").map(&:split).freeze

SHAPE_SCORES = {rock: 1, paper: 2, scissors: 3}.freeze
OUTCOME_SCORES = {win: 6, draw: 3, loss: 0}.freeze

PLAYS = {"A" => :rock, "B" => :paper, "C" => :scissors}.freeze
RESPONSES = {"X" => :rock, "Y" => :paper, "Z" => :scissors}.freeze
OUTCOMES = {"X" => :loss, "Y" => :draw, "Z" => :win}.freeze

RESULTS = {
  rock: {rock: :draw, paper: :win, scissors: :loss},
  paper: {rock: :loss, paper: :draw, scissors: :win},
  scissors: {rock: :win, paper: :loss, scissors: :draw}
}.freeze

def response_score_for((play, response))
  response = RESPONSES[response]
  outcome = RESULTS[PLAYS[play]][response]

  OUTCOME_SCORES[outcome] + SHAPE_SCORES[response]
end

solve!(
  "Your total score following the move-based strategy guide is:",
  ROUNDS.sum { |round| response_score_for(round) }
)

def outcome_score_for((play, outcome))
  outcome = OUTCOMES[outcome]
  response = RESULTS[PLAYS[play]].key(outcome)

  OUTCOME_SCORES[outcome] + SHAPE_SCORES[response]
end

solve!(
  "Your total score following the outcome-based strategy guide is:",
  ROUNDS.sum { |round| outcome_score_for(round) }
)
