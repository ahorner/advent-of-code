LINES = INPUT.split("\n").map(&:chars)

PAIRINGS = { "(" => ")", "[" => "]", "{" => "}", "<" => ">" }.freeze
ERROR_SCORES = { ")" => 3, "]" => 57, "}" => 1197, ">" => 25137 }.freeze

AutocompleteError = Class.new(RuntimeError)

def autocomplete(line)
  unresolved = []

  line.each do |char|
    case char
    when *PAIRINGS.keys
      unresolved << char
      false
    when PAIRINGS[unresolved.last]
      unresolved.pop
      false
    when *PAIRINGS.values
      raise AutocompleteError, char
    end
  end

  unresolved.reverse.map { |c| PAIRINGS[c] }
end

def corrupted?(line)
  autocomplete(line)
  false
rescue AutocompleteError
  true
end

corrupted, incomplete = LINES.partition { |line| corrupted?(line) }
error_score = corrupted.sum do |line|
  autocomplete(line)
rescue AutocompleteError => e
  ERROR_SCORES[e.message]
end

solve!("The total syntax error score is:", error_score)

COMPLETION_SCORES = { ")" => 1, "]" => 2, "}" => 3, ">" => 4 }.freeze

completion_scores = incomplete.map do |line|
  autocomplete(line).inject(0) { |score, c| score * 5 + COMPLETION_SCORES[c] }
end

solve!("The middle autocomplete score is:", completion_scores.sort[completion_scores.length / 2])
