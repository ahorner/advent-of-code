require "set"

class Party
  # rubocop:disable Layout/LineLength
  INTERACTION_MATCHER = /(?<person>.+) would (?<action>.+) (?<units>\d+) happiness units by sitting next to (?<neighbor>.+)\./.freeze
  # rubocop:enable Layout/LineLength

  attr_reader :people

  def initialize
    @people = Set.new
    @relationships = Hash.new(0)
  end

  def parse(guest_list)
    guest_list.each do |line|
      interaction = INTERACTION_MATCHER.match(line)

      @people << interaction[:person]
      @people << interaction[:neighbor]

      units = interaction[:units].to_i
      units *= -1 if interaction[:action] == "lose"

      @relationships[[interaction[:person], interaction[:neighbor]]] = units
    end
  end

  def seating_chart
    @people.to_a.permutation.map do |arrangement|
      SeatingChart.new(arrangement, @relationships)
    end.max
  end
end

class SeatingChart
  def initialize(arrangement, relationships)
    @relationships = relationships
    @arrangement = arrangement
  end

  def happiness
    @happiness ||= begin
      total = 0

      @arrangement.each.with_index do |person, index|
        total += @relationships[[person, @arrangement[(index + 1) % @arrangement.size]]]
        total += @relationships[[person, @arrangement[index - 1]]]
      end

      total
    end
  end

  def <=>(other)
    happiness <=> other.happiness
  end

  def to_s
    (@arrangement + [@arrangement.first]).join(" - ")
  end
end

party = Party.new
party.parse(INPUT.split("\n"))

seating_chart = party.seating_chart

solve!("Best arrangement:", seating_chart.to_s, seating_chart.happiness)

party.people << "Me"
seating_chart = party.seating_chart

solve!("Best arrangement (with me):", seating_chart.to_s, seating_chart.happiness)
