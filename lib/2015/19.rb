require "set"

class Reaction
  attr_reader :base, :result

  def initialize(base, result)
    @base = base
    @result = result
  end

  def possible_formulas(formula)
    new_formulas = []

    sequence = formula.scan(/[A-Z][a-z]?/)
    sequence.each_with_index do |component, position|
      next unless component == base

      new_sequence = sequence.dup
      new_sequence[position] = result
      new_formulas << new_sequence.join
    end

    new_formulas
  end

  def can_decompose?(formula)
    formula.include?(result)
  end

  def decompose(formula)
    formula.sub(result, base)
  end
end

lines = INPUT.split("\n").reject(&:empty?)

FORMULA = lines.pop
REACTIONS = lines.map { |line| Reaction.new(*line.split(" => ")) }
ELECTRON = "e"

all_reactions = REACTIONS.each_with_object(Set.new) do |reaction, set|
  set.merge(reaction.possible_formulas(FORMULA))
end

solve!("Total possible results:", all_reactions.size)

def decompose(formula, reactions)
  steps = 0

  loop do
    return if reactions.none? { |reaction| reaction.can_decompose?(formula) }

    reactions.each do |reaction|
      break if reaction.base == "e" && formula.length > reaction.result.length
      next unless reaction.can_decompose?(formula)

      formula = reaction.decompose(formula)
      steps += 1

      return steps if formula == ELECTRON
    end
  end
end

def decomposition_steps(formula)
  REACTIONS.permutation.each do |reactions|
    steps = decompose(formula, reactions)
    return steps if steps
  end

  nil
end

solve!("Steps required to compose formula:", decomposition_steps(FORMULA))
