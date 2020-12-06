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
  # rubocop:disable Layout/LineLength
  INGREDIENT_PATTERN = /(?<ingredient>.+): capacity (?<capacity>.+), durability (?<durability>.+), flavor (?<flavor>.+), texture (?<texture>.+), calories (?<calories>.+)/.freeze
  # rubocop:enable Layout/LineLength

  def initialize
    @ingredients = {}
  end

  def stock(ingredients)
    ingredients.each do |ingredient|
      qualities = INGREDIENT_PATTERN.match(ingredient)

      @ingredients[qualities[:ingredient]] = {
        capacity: qualities[:capacity].to_i,
        durability: qualities[:durability].to_i,
        flavor: qualities[:flavor].to_i,
        texture: qualities[:texture].to_i,
        calories: qualities[:calories].to_i,
      }
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

puts "Best cookie:", kitchen.best_cookie(100).score, nil
puts "Best cookie (500 cal):", kitchen.best_cookie(100, 500).score
