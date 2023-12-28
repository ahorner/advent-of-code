require "matrix"
require "z3"

Hailstone = Data.define(:position, :velocity) do
  def intersection(other)
    x, y = position.to_a
    dx, dy = velocity.to_a
    ox, oy = other.position.to_a
    odx, ody = other.velocity.to_a

    determinant = ody * dx - odx * dy
    return nil if determinant == 0

    t = (odx * (y - oy) - ody * (x - ox)) / determinant.to_f
    nx = x + t * dx
    ny = y + t * dy

    return nil if (nx - x) * dx < 0 || (nx - ox) * odx < 0

    Vector[nx, ny]
  end
end

HAILSTONES = INPUT.split("\n").map do |line|
  position, velocity = line.split(" @ ")

  position = Vector[*position.tr(" ", "").split(",").map(&:to_i)]
  velocity = Vector[*velocity.tr(" ", "").split(",").map(&:to_i)]

  Hailstone.new(position:, velocity:)
end

RANGE ||= 200000000000000..400000000000000

count = HAILSTONES.combination(2).count do |a, b|
  intersection = a.intersection(b)
  next false if intersection.nil?

  RANGE.cover?(intersection[0]) && RANGE.cover?(intersection[1])
end

solve!("The number of overlapping trajectories is:", count)

# I don't love pulling in Z3 here, but this is incredibly non-trivial to solve
# algorithmically.
x, y, z, dx, dy, dz = %w[x y z dx dy dz].map { |c| Z3::Int(c) }
solver = HAILSTONES.first(3).each_with_object(Z3::Solver.new) do |hailstone, solver|
  i, j, k = hailstone.position.to_a
  di, dj, dk = hailstone.velocity.to_a

  time = Z3::Int("t#{i}")
  solver.assert(time > 0)
  solver.assert(x + dx * time == i + di * time)
  solver.assert(y + dy * time == j + dj * time)
  solver.assert(z + dz * time == k + dk * time)
end

raise "Not all stones can be hit by a single rock" unless solver.satisfiable?
solve!("The sum of your rock's coordinates should be:", [x, y, z].sum { |p| solver.model[p].to_i })
