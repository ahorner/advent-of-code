RECIPE_MATCHER = /^(?<ingredients>.+) \(contains (?<allergens>.+)\)$/.freeze

allergens = {}

RECIPES = INPUT.split("\n").each_with_object([]) do |recipe, recipes|
  data = RECIPE_MATCHER.match(recipe)

  ingredients = data[:ingredients].split
  recipes << ingredients

  data[:allergens].split(", ").each do |allergen|
    allergens[allergen] ||= ingredients
    allergens[allergen] &= ingredients
  end
end

ALLERGENS =
  loop do
    known, unknown = allergens.partition { |_, options| options.length == 1 }
    break allergens.transform_values(&:first).freeze if unknown.empty?

    known = known.map(&:last).reduce(:|)
    unknown.each { |allergen, _| allergens[allergen] -= known }
  end

solve!("The quantity of inert ingredients is:",
  RECIPES.sum { |ingredients| (ingredients - ALLERGENS.values).count })

solve!("The canonical dangerous ingredient list is:",
  ALLERGENS.sort_by(&:first).map(&:last).join(","))
