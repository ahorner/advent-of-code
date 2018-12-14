COUNT = INPUT.to_i
STARTING_RECIPES = [3, 7].freeze

class Search
  attr_reader :previous

  def initialize(term)
    @term = term
    @current = []
    @previous = 0
  end

  def add(recipes)
    recipes.each do |r|
      @current.shift && @previous += 1 if @current.size == @term.size
      @current << r
      break if found?
    end
  end

  def found?
    @term == @current
  end
end

recipes = STARTING_RECIPES.dup
elves = [0, 1]

search = Search.new(COUNT.digits.reverse)
search.add(recipes)

loop do
  scores = elves.map { |elf| recipes[elf].to_i }
  new_recipes = scores.sum.digits.reverse

  recipes.concat(new_recipes)
  search.add(new_recipes)

  break if search.found?

  elves.each_index { |i| elves[i] = (elves[i] + scores[i] + 1) % recipes.size }
end

puts "The score of the recipes after practice is:", recipes.slice(COUNT, 10).join(""), nil
puts "The number of recipes preceding the sequence is:", search.previous
