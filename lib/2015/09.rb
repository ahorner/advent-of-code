require "set"

class Map
  def initialize
    @cities = Set.new
    @edges = {}
  end

  def fill(lines)
    lines.each do |line|
      cities, distance = line.split(" = ")
      origin, destination = cities.split(" to ")

      @cities << origin
      @cities << destination

      @edges[[origin, destination].sort] = distance.to_i
    end
  end

  def best_route
    route(routes.values.min)
  end

  def worst_route
    route(routes.values.max)
  end

  private

  def route(distance)
    [routes.key(distance).join(" -> "), distance]
  end

  def routes
    @routes ||= @cities.to_a.permutation.each_with_object({}) do |route, distances|
      origin = nil
      destination = nil

      distance = route.map do |city|
        origin = destination
        destination = city
        next if origin.nil?

        distance(origin, destination)
      end.compact.sum

      distances[route] = distance
    end
  end

  def distance(origin, destination)
    @edges[[origin, destination].sort]
  end
end

map = Map.new
map.fill(INPUT.split("\n"))

solve!("Best route:", *map.best_route)
solve!("Worst route:", *map.worst_route)
