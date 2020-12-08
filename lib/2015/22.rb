class Character
  class Dead < RuntimeError; end

  attr_accessor :attack, :armor, :mp, :mana_used
  attr_reader :hp

  def initialize(hp, attack, mp = 0)
    @hp = hp
    @mp = mp
    @attack = attack
    @armor = 0
    @mana_used = 0
  end

  def hp=(value)
    @hp = value
    raise Dead if value < 0
  end

  def hit(power)
    self.hp -= [(power - @armor), 1].max
  end

  def debuff
    @armor = 0
  end
end

class Skill
  attr_reader :name, :cost

  def initialize(name, cost, cooldown = 0, &callback)
    @name = name
    @cost = cost
    @cooldown = cooldown
    @effect = callback
    @timer = 0
  end

  def cast(caster, enemy)
    caster.mp -= cost
    caster.mana_used += cost

    if @cooldown > 0
      @timer = @cooldown
    else
      @effect.call(caster, enemy)
    end
  end

  def tick(caster, enemy)
    return unless active?

    @effect.call(caster, enemy)
    @timer -= 1
  end

  def castable_by?(caster)
    @timer <= 1 && @cost <= caster.mp
  end

  def active?
    @timer > 0
  end
end

SKILLS = [
  # DRAIN is less efficient than MAGIC MISSILE, and only prolongs the battle
  Skill.new("DRAIN", 73) { |hero, enemy| enemy.hit(2) && hero.hp += 2 },
  Skill.new("MAGIC MISSILE", 53) { |_hero, enemy| enemy.hit(4) },
  Skill.new("SHIELD", 113, 6) { |hero, _enemy| hero.armor = 7 },
  Skill.new("POISON", 173, 6) { |_hero, enemy| enemy.hit(3) },
  Skill.new("RECHARGE", 229, 5) { |hero, _enemy| hero.mp += 101 },
].freeze

class Battle
  attr_reader :hero, :enemy, :skills

  def initialize(hero, enemy, skills, hard_mode: false)
    @hero = hero
    @enemy = enemy
    @skills = skills
    @hard_mode = hard_mode
  end

  def optimal_strategy(minimum = 9999)
    return minimum if hero.mana_used >= minimum

    save_scum do |save_state, won|
      minimum =
        if won
          [save_state.hero.mana_used, minimum].min
        else
          save_state.optimal_strategy(minimum)
        end
    end

    minimum
  end

  def save_scum
    skills.size.times do |i|
      state = save_state
      outcome = state.resolve(state.skills[i])

      yield(state, outcome) unless outcome == false
    end
  end

  def resolve(skill)
    return false unless skill.castable_by?(hero)

    # Hero's turn
    hero.hp -= 1 if @hard_mode
    resolve_effects
    skill.cast(hero, enemy)

    # Enemy's Turn
    resolve_effects
    hero.hit(enemy.attack)

    nil
  rescue Character::Dead
    enemy.hp <= 0
  end

  private

  def resolve_effects
    hero.debuff
    skills.each { |s| s.tick(hero, enemy) }
  end

  def save_state
    Battle.new(hero.clone, enemy.clone, skills.map(&:clone), hard_mode: @hard_mode)
  end
end

HERO_STATS ||= [50, 0, 500].freeze

enemy_stats = INPUT.split("\n").map { |i| i.scan(/\d+/).join.to_i }
enemy = Character.new(*enemy_stats)
hero = Character.new(*HERO_STATS)

best = Battle.new(hero, enemy, SKILLS).optimal_strategy
solve!("Cheapest strategy:", best)

best = Battle.new(hero, enemy, SKILLS, hard_mode: true).optimal_strategy
solve!("Cheapest strategy (hard mode):", best)
