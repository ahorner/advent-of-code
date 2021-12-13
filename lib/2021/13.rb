folding = false
folds, points = INPUT.split("\n").partition do |line|
  folding = true if line.empty?
  folding
end

FOLD_MATCHER = /\Afold along (?<axis>x|y)=(?<point>\d+)\z/.freeze
POINTS = points.map { |line| line.split(",").map(&:to_i) }.freeze
FOLDS = folds.drop(1).map { |line| line.match(FOLD_MATCHER) }

def fold(paper, fold)
  fulcrum = fold[:point].to_i

  paper.keys.each_with_object({}) do |(x, y), folded|
    x, y =
      case fold[:axis]
      when "x"
        [x > fulcrum ? fulcrum - (x - fulcrum) : x, y]
      when "y"
        [x, y > fulcrum ? fulcrum - (y - fulcrum) : y]
      end

    folded[[x, y]] = true
  end
end

paper = POINTS.each_with_object({}) { |(x, y), sheet| sheet[[x, y]] = true }
paper = fold(paper, FOLDS[0])

solve!("The number of visible dots after the first fold is:", paper.values.count)

paper = POINTS.each_with_object({}) { |(x, y), sheet| sheet[[x, y]] = true }
FOLDS.each { |instruction| paper = fold(paper, instruction) }

final = (0..paper.keys.map(&:last).max).each_with_object("") do |y, rendered|
  (0..paper.keys.map(&:first).max).each { |x| rendered << (paper[[x, y]] ? "#" : ".") }
  rendered << "\n"
end

solve!("The paper looks like this after folding:", final)
