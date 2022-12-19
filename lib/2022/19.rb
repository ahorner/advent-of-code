require "matrix"

class Resource < Vector
  TYPES = %i[ore clay obsidian geode]

  def [](type)
    case type
    when :ore then super(0)
    when :clay then super(1)
    when :obsidian then super(2)
    when :geode then super(3)
    else super
    end
  end
end

class Blueprint
  BOTS = {
    ore: Vector[1, 0, 0, 0],
    clay: Vector[0, 1, 0, 0],
    obsidian: Vector[0, 0, 1, 0],
    geode: Vector[0, 0, 0, 1]
  }

  attr_reader :id

  def initialize(id:, bots:)
    @id = id
    @bots = bots
    @needs = Resource::TYPES.to_h do |resource|
      [resource, @bots.map { |_, cost| cost[resource] }.max]
    end
  end

  def [](resource)
    @bots[resource]
  end

  def max_needed(resource)
    @needs[resource]
  end

  def impossible?(bot, production)
    costs = @bots[bot]
    Resource::TYPES.any? do |resource|
      costs[resource] > 0 && production[resource] == 0
    end
  end

  def buildable?(bot, resources)
    (resources - self[bot]).none?(&:negative?)
  end
end

BLUEPRINT_MATCHER = /Blueprint (?<id>\d+)/
BOT_MATCHER = /Each (?<resource>[a-z]+) robot costs (?<costs>[^.]+)\./
RESOURCE_MATCHER = /(?<amount>\d+) (?<resource>[a-z]+)/

BLUEPRINTS = INPUT.split("\n").map do |description|
  id = BLUEPRINT_MATCHER.match(description)[:id].to_i
  bots = description.scan(BOT_MATCHER).to_h do |bot, costs|
    costs = costs.scan(RESOURCE_MATCHER).to_h { |amount, resource| [resource.to_sym, amount] }
    costs = Resource::TYPES.map { |resource| costs[resource].to_i }

    [bot.to_sym, Resource[*costs]]
  end

  Blueprint.new(id:, bots:)
end

def potential_geodes(time)
  (time - 1) * time / 2
end

def max_geodes(blueprint, time, focus: nil, production: Resource[1, 0, 0, 0], inventory: Resource[0, 0, 0, 0], best: 0)
  if focus.nil?
    return Resource::TYPES.reduce(best) do |best, resource|
      max_geodes(blueprint, time, focus: resource, production:, inventory:, best:)
    end
  end

  return [best, inventory[:geode]].max if focus != :geode && production[focus] >= blueprint.max_needed(focus)
  return [best, inventory[:geode]].max if blueprint.impossible?(focus, production)

  theoretical = inventory[:geode] + production[:geode] * time + potential_geodes(time)
  return best if theoretical <= best

  loop do
    break [best, inventory[:geode]].max if time == 0

    if blueprint.buildable?(focus, inventory)
      new_inventory = inventory - blueprint[focus] + production
      new_production = production + Blueprint::BOTS[focus]

      return Resource::TYPES.reduce(best) do |best, resource|
        max_geodes(blueprint, time - 1, focus: resource, production: new_production, inventory: new_inventory, best:)
      end
    end

    time -= 1
    inventory += production
  end
end

solve!(
  "The sum of blueprint quality levels is:",
  BLUEPRINTS.map { |bp| bp.id * max_geodes(bp, 24) }.sum
)

solve!(
  "The product of maximum geodes opened is:",
  BLUEPRINTS.first(3).map { |bp| max_geodes(bp, 32) }.reduce(:*)
)
