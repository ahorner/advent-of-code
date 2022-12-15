WEAPONS = {
  "Unarmed" => {cost: 0, attack: 0, defense: 0},
  "Dagger" => {cost: 8, attack: 4, defense: 0},
  "Shortsword" => {cost: 10, attack: 5, defense: 0},
  "Warhammer" => {cost: 25, attack: 6, defense: 0},
  "Longsword" => {cost: 40, attack: 7, defense: 0},
  "Greataxe" => {cost: 74, attack: 8, defense: 0}
}.values

ARMOR = {
  "Naked" => {cost: 0, attack: 0, defense: 0},
  "Leather" => {cost: 13, attack: 0, defense: 1},
  "Chainmail" => {cost: 31, attack: 0, defense: 2},
  "Splintmail" => {cost: 53, attack: 0, defense: 3},
  "Bandedmail" => {cost: 75, attack: 0, defense: 4},
  "Platemail" => {cost: 102, attack: 0, defense: 5}
}.values

RINGS = {
  "Damage +1" => {cost: 25, attack: 1, defense: 0},
  "Damage +2" => {cost: 50, attack: 2, defense: 0},
  "Damage +3" => {cost: 100, attack: 3, defense: 0},
  "Defense +1" => {cost: 20, attack: 0, defense: 1},
  "Defense +2" => {cost: 40, attack: 0, defense: 2},
  "Defense +3" => {cost: 80, attack: 0, defense: 3}
}.values

class Equipment
  def initialize(items = [])
    @items = items
  end

  def attack
    @items.map { |i| i[:attack] }.inject(0, :+)
  end

  def defense
    @items.map { |i| i[:defense] }.inject(0, :+)
  end

  def cost
    @items.map { |i| i[:cost] }.inject(0, :+)
  end
end

class Character
  attr_reader :hp

  def initialize(hit_points, attack, defense)
    @hp = hit_points
    @attack = attack
    @defense = defense
  end

  def equip(equipment)
    @equipment = equipment
  end

  def beats?(enemy)
    turns_to_kill = (enemy.hp.to_f / [(attack - enemy.defense), 1].max).ceil
    turns_to_die = (hp.to_f / [(enemy.attack - defense), 1].max).ceil

    turns_to_kill <= turns_to_die
  end

  def attack
    @attack + equipment.attack
  end

  def defense
    @defense + equipment.defense
  end

  def equipment
    @equipment || Equipment.new
  end
end

def loadouts
  rings = (0..2).flat_map { |i| RINGS.combination(i).to_a }
  combinations = WEAPONS.product(ARMOR).product(rings).map(&:flatten)
  combinations.map { |loadout| Equipment.new(loadout) }
end

ENEMY_STATS = INPUT.split("\n").map { |line| line.scan(/\d+/).join.to_i }
enemy = Character.new(*ENEMY_STATS)

HERO_STATS ||= [100, 0, 0].freeze
hero = Character.new(*HERO_STATS)

winning_loadouts, losing_loadouts = loadouts.partition do |equipment|
  hero.equip(equipment)
  hero.beats?(enemy)
end

solve!("Cheapest winning loadout:", winning_loadouts.min_by(&:cost).cost)
solve!("Most expensive losing loadout:", losing_loadouts.max_by(&:cost).cost)
