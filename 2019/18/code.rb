GRID = INPUT.split("\n").each_with_index.each_with_object({}) do |(line, y), grid|
  line.split("").each_with_index { |tile, x| grid[[x, y]] = tile }
end.freeze

class Vault
  DIRECTIONS = [[0, -1], [0, 1], [-1, 0], [1, 0]].freeze

  KEY_MATCHER = /\A[[:lower:]]\z/
  DOOR_MATCHER = /\A[[:upper:]]\z/

  ENTRANCE = "@"
  WALL = "#"

  def initialize(map)
    @map = map
  end

  def chambers
    entrances.keys
  end

  def key_paths
    @key_paths ||= keys.merge(entrances).each_with_object({}) do |(key, location), routes|
      queue = [[location, []]]
      distances = { location => 0 }
      keys = []

      while queue.any?
        tile, requirements = queue.shift

        adjacent_tiles(tile).each do |target|
          next if distances[target]

          distances[target] = distances[tile] + 1
          keys << [@map[target], requirements, distances[target]] if key?(target)

          queue << if interactive?(target)
            [target, requirements + [@map[target].downcase]]
          else
            [target, requirements]
          end
        end
      end

      routes[key] = keys
    end
  end

  private

  def keys
    @keys ||= @map.each_with_object({}) do |(tile, c), collection|
      collection[c] = tile if key?(tile)
    end
  end

  def entrances
    @entrances ||= begin
      entrance_tiles = @map.select { |_, c| c == ENTRANCE }
      Hash[entrance_tiles.map.with_index { |(tile, _), chamber| ["@#{chamber}", tile] }]
    end
  end

  def interactive?(tile)
    door?(tile) || key?(tile)
  end

  def door?(tile)
    @map[tile] =~ DOOR_MATCHER
  end

  def key?(tile)
    @map[tile] =~ KEY_MATCHER
  end

  def wall?(tile)
    @map[tile] == WALL
  end

  def adjacent_tiles((x, y))
    DIRECTIONS.map { |i, j| [x + i, y + j] }.reject { |coords| wall?(coords) }
  end
end

class Explorer
  def initialize(key_paths)
    @key_paths = key_paths
  end

  def steps_from(origins, inventory = [], cache = {})
    cache[[origins.sort.join, inventory.sort.join]] ||= begin
      keys = reachable_keys(origins, inventory)

      if keys.any?
        keys.map do |chamber, key, distance|
          positions = origins.dup.tap { |pos| pos[chamber] = key }
          distance + steps_from(positions, inventory + [key], cache)
        end.min
      else
        0
      end
    end
  end

  private

  def reachable_keys(origins, inventory)
    origins.each_with_index.each_with_object([]) do |(origin, chamber), keys|
      @key_paths[origin].each do |key, requirements, distance|
        next if inventory.include?(key)
        next unless (requirements - inventory).empty?

        keys << [chamber, key, distance]
      end
    end
  end
end

vault = Vault.new(GRID)
explorer = Explorer.new(vault.key_paths)
puts "The minimum number of steps to find all keys is:", explorer.steps_from(vault.chambers), "\n"

CHAMBERED_GRID = GRID.dup.tap do |grid|
  x, y = GRID.key(Vault::ENTRANCE)
  [[-1, -1], [1, -1], [-1, 1], [1, 1]].each { |i, j| grid[[x + i, y + j]] = Vault::ENTRANCE }
  [[0, -1], [-1, 0], [0, 0], [1, 0], [0, 1]].each { |i, j| grid[[x + i, y + j]] = Vault::WALL }
end.freeze

vault = Vault.new(CHAMBERED_GRID)
explorer = Explorer.new(vault.key_paths)
puts "The minimum number of steps to find all keys in the chambered vault is:", explorer.steps_from(vault.chambers)
