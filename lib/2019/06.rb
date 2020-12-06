ORBITS = Hash[INPUT.split("\n").map { |orbit| orbit.split(")").reverse }]

class OrbitMap
  CENTER = "COM".freeze

  def initialize(orbits)
    @map = orbits
    @checksums = {}
  end

  def total_orbits
    @map.keys.map { |object| orbits_for(object).size }.sum
  end

  def transfers_between(origin, destination)
    from_origin = orbits_for(origin)
    from_destination = orbits_for(destination)

    (from_origin + from_destination - (from_origin & from_destination)).size
  end

  private

  def orbits_for(object)
    orbits = []

    until object == CENTER
      object = @map[object]
      orbits.push(object)
    end

    orbits
  end
end

map = OrbitMap.new(ORBITS)
puts "The total number of direct and indirect orbits is:", map.total_orbits, "\n"
puts "The minimum number of orbital transfers to Santa is:", map.transfers_between("YOU", "SAN")
