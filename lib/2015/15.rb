class Cookie
  def initialize
    @qualities = Hash.new(0)
  end

  def add(ingredient)
    ingredient.each do |quality, value|
      @qualities[quality] += value
    end
  end

  def score(target_calories = nil)
    return 0 unless target_calories.nil? || target_calories == score_for(:calories)

    [
      score_for(:capacity),
      score_for(:durability),
      score_for(:flavor),
      score_for(:texture),
    ].inject(:*)
  end

  private

  def score_for(quality)
    [@qualities[quality], 0].max
  end
end

class Kitchen
  INGREDIENT_PATTERN = /^(?<name>.+): (?<attributes>.+)$/.freeze
  ATTRIBUTE_MATCHER = /\b(?<name>\w+) (?<value>-?\d+)\b/.freeze

  def initialize
    @ingredients = {}
  end

  def stock(ingredients)
    ingredients.each do |ingredient|
      ingredient = INGREDIENT_PATTERN.match(ingredient)
      attributes = ingredient[:attributes].split(", ").map do |attribute|
        attribute = attribute.match(ATTRIBUTE_MATCHER)
        [attribute[:name].to_sym, attribute[:value].to_i]
      end

      @ingredients[ingredient[:name]] = Hash[attributes]
    end
  end

  def best_cookie(teaspoons, calories = nil)
    cookies = recipes(teaspoons).map { |ingredients| cookie(ingredients) }
    cookies.max_by { |cookie| cookie.score(calories) }
  end

  private

  def cookie(ingredients)
    Cookie.new.tap do |cookie|
      ingredients.each { |ingredient| cookie.add(@ingredients[ingredient]) }
    end
  end

  def recipes(teaspoons)
    @ingredients.keys.repeated_combination(teaspoons).to_a
  end
end

kitchen = Kitchen.new
kitchen.stock(INPUT.split("\n"))

solve!("Best cookie:", kitchen.best_cookie(100).score)
solve!("Best cookie (500 cal):", kitchen.best_cookie(100, 500).score)
