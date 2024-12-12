require "matrix"

GARDEN = INPUT.split("\n").each_with_index.each_with_object({}) do |(row, y), map|
  row.chars.each_with_index do |plot, x|
    map[Vector[x, y]] = plot
  end
end
ADJACENCIES = [Vector[1, 0], Vector[0, 1], Vector[-1, 0], Vector[0, -1]]

def regions_in(garden)
  plots = garden.keys
  regions = []

  loop do
    plot = plots.shift
    break regions unless plot

    crop = garden[plot]

    region = {}
    perimeters = Hash.new(0)

    connected = [plot]

    loop do
      plot = connected.shift
      break unless plot
      next if region[plot]

      region[plot] = true

      ADJACENCIES.each do |test|
        neighbor = plot + test

        if garden[neighbor] != crop
          perimeters[plot] += 1
        else
          connected << neighbor
        end
      end
    end

    plots -= region.keys
    regions << {plots: region, perimeters:}
  end
end

def fence_cost(region)
  region[:plots].length * region[:perimeters].values.sum
end

regions = regions_in(GARDEN)
solve!(regions.sum { |region| fence_cost(region) })

CORNER_TESTS = [
  [Vector[1, 0], Vector[0, 1], Vector[1, 1]],
  [Vector[1, 0], Vector[0, -1], Vector[1, -1]],
  [Vector[-1, 0], Vector[0, 1], Vector[-1, 1]],
  [Vector[-1, 0], Vector[0, -1], Vector[-1, -1]]
]

def sides_for(region)
  region.keys.each_with_object(Hash.new(0)) do |plot, corners|
    CORNER_TESTS.each do |corner|
      x, y, test = corner.map { |v| region[plot + v] }
      corners[plot] += 1 if (x && y && !test) || !(x || y)
    end
  end.values.sum
end

def side_fence_cost(region)
  region[:plots].length * sides_for(region[:plots])
end

solve!(regions.sum { |region| side_fence_cost(region) })
