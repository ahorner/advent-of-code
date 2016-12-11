class Item

  attr_reader :element, :type

  def initialize(element, type)
    @element = element
    @type = type
  end

  def chip?
    type == :chip
  end

end

class State

  attr_reader :steps

  def initialize(floorplan, floor = 0, steps = 0)
    @floorplan = floorplan
    @floor = floor
    @steps = steps
  end

  def valid_moves
    destinations = [@floor + 1, @floor - 1].select { |floor| floor >= 0 && floor < @floorplan.length }
    transfers = [2, 1].flat_map { |load| @floorplan[@floor].combination(load).to_a }
    destinations.flat_map do |floor|
      transfers.map { |transfer| move_to(floor, transfer) }
    end.compact.select(&:valid?)
  end

  def solved?
    @floorplan[0].empty? && @floorplan[1].empty? && @floorplan[2].empty?
  end

  def valid?
    @floorplan.all? do |items|
      chips, generators = items.partition(&:chip?)
      generators.empty? || (chips.map(&:element) - generators.map(&:element)).empty?
    end
  end

  def key
    [@floor, pair_layout]
  end

  private

  def move_to(new_floor, take)
    vacated = new_floor == @floorplan.index(&:any?) - 1
    pair = take.map(&:element).uniq.length < take.length

    return if new_floor < @floor && (vacated || pair)

    floorplan = @floorplan.map.with_index do |items, floor|
      case floor
      when @floor then items - take
      when new_floor then items + take
      else items
      end
    end

    State.new(floorplan, new_floor, @steps + 1)
  end

  def pair_layout
    locations = Hash.new { |h, k| h[k] = { generator: nil, chip: nil } }

    @floorplan.each_with_index do |items, floor|
      items.each { |item| locations[item.element][item.type] = floor }
    end

    locations.values.map(&:values).sort
  end

end

def steps(floorplan)
  @queue = [State.new(floorplan)]
  @cache = {}

  begin
    @queue.shift.valid_moves.each do |move|
      return move.steps if move.solved?
      next if @cache.key?(move.key)
      @cache[move.key] = true
      @queue << move
    end
  end until @queue.empty?
end

FLOOR_MATCHER = /\AThe (?<floor>.+) floor contains (?<contents>.+)\.\z/.freeze
CHIP_MATCHER = /a (?<element>\w+)-compatible microchip/.freeze
GENERATOR_MATCHER = /a (?<element>\w+) generator/.freeze

floorplan = INPUT.split("\n").map do |line|
  floor = line.match(FLOOR_MATCHER)

  items = []
  floor[:contents].scan(CHIP_MATCHER) { items << Item.new($~[:element], :chip) }
  floor[:contents].scan(GENERATOR_MATCHER) { items << Item.new($~[:element], :generator) }

  items
end

puts "You can transport all equipment to the top floor in:", steps(floorplan), nil

new_items = [
  Item.new("elerium", :generator),
  Item.new("elerium", :chip),
  Item.new("dilithium", :generator),
  Item.new("dilithium", :chip),
]

new_floorplan = [floorplan[0] + new_items, *floorplan[1..-1]]
puts "You can transport the updated equipment list to the top floor in:", steps(new_floorplan)
