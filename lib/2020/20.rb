require "delegate"

class Image < SimpleDelegator
  def variants
    base = __getobj__

    [
      base,
      base.map(&:reverse),
      base.reverse,
      base.reverse.map(&:reverse),
      base.transpose,
      base.transpose.map(&:reverse),
      base.transpose.reverse,
      base.transpose.reverse.map(&:reverse)
    ].uniq.map { |grid| Image.new(grid) }
  end
end

class Tile
  attr_reader :id, :image

  def initialize(image, id: nil)
    @image = image
    @id = id
  end

  def content
    image[1...-1].map { |row| row[1...-1] }
  end

  def fits?(tile, direction)
    return true unless tile

    case direction
    when :right then image.each_index.all? { |y| image[y][-1] == tile.image[y][0] }
    when :bottom then image[-1] == tile.image[0]
    end
  end

  def variants
    @variants ||= image.variants.map { |variant| Tile.new(variant, id: id) }
  end
end

TILE_MATCHER = /Tile (\d+):\n([.#\n]+)/
TILES = INPUT.scan(TILE_MATCHER).map do |id, grid|
  grid = Image.new(grid.split("\n").map(&:chars))
  Tile.new(grid, id: id.to_i)
end.freeze

SIZE = Math.sqrt(TILES.count).to_i

def arrangement_for(tiles, x, y, layout = Array.new(SIZE) { Array.new(SIZE) })
  return layout if x >= SIZE || y >= SIZE

  tiles.each do |tile|
    next if layout.any? { |row| row.compact.any? { |t| t.id == tile.id } }

    tile.variants.each do |variant|
      next unless
        (x == 0 || layout[y][x - 1].fits?(variant, :right)) &&
          (y == 0 || layout[y - 1][x].fits?(variant, :bottom))

      updated = layout.dup.tap { |l| l[y][x] = variant }
      i = (x + 1) % SIZE
      j = (i == 0) ? y + 1 : y

      arrangement = arrangement_for(tiles, i, j, updated)
      return arrangement if arrangement
    end
  end

  nil
end

arrangement = arrangement_for(TILES, 0, 0)
corner_ids = [0, SIZE - 1].repeated_permutation(2).map { |x, y| arrangement[x][y].id }

solve!("The product of corner tile IDs is:", corner_ids.inject(:*))

class MonsterScanner
  def initialize(monster)
    @monster_mask = mask_for(monster)

    @height = monster.size
    @width = monster[0].size
  end

  def count_for(image)
    image.variants.detect do |variant|
      count = scan(variant)
      break count if count > 0
    end
  end

  private

  def scan(image)
    image.each_cons(@height).sum do |layer|
      scanlines = layer.map { |line| line.each_cons(@width) }
      regions = scanlines[0].zip(*scanlines[1..])

      regions.count { |region| mask_for(region) & @monster_mask == @monster_mask }
    end
  end

  def mask_for(image)
    image.map(&:join).join.tr(".#", "01").to_i(2)
  end
end

MONSTER = <<~TXT.split("\n").map(&:chars).freeze
  ..................#.
  #....##....##....###
  .#..#..#..#..#..#...
TXT

IMAGE = Image.new(arrangement.flat_map do |tiles|
  contents = tiles.map(&:content)
  contents[0].zip(*contents[1..]).map { |row| row.inject(:+) }
end)

monsters = MonsterScanner.new(MONSTER).count_for(IMAGE)
roughness = IMAGE.flatten.count("#") - (MONSTER.flatten.count("#") * monsters)

solve!("The water roughness of the sea monster habitat is:", roughness)
