TARGET_MATCHER = /\Atarget area: x=(?<x>.+), y=(?<y>.+)\z/

ranges = INPUT.match(TARGET_MATCHER)

X_RANGE = eval(ranges[:x]).freeze
Y_RANGE = eval(ranges[:y]).freeze
STARTING_POSITION = [0, 0].freeze

def hits?(dx, dy)
  x, y = STARTING_POSITION

  loop do
    x += dx
    y += dy

    break true if X_RANGE.include?(x) && Y_RANGE.include?(y)
    break false if x > X_RANGE.end || y < Y_RANGE.begin

    dx -= 1 if dx > 0
    dy -= 1
  end
end

def peak(dy)
  dy * (dy + 1) / 2
end

POSSIBLE_X = (Math.sqrt(2 * X_RANGE.begin).floor..X_RANGE.end).to_a.freeze
POSSIBLE_Y = (Y_RANGE.begin..-Y_RANGE.begin).to_a.freeze

hits = POSSIBLE_X.product(POSSIBLE_Y).select { |dx, dy| hits?(dx, dy) }

solve!("The maximum height reached on a successful shot is:", hits.map { |_, dy| peak(dy) }.max)
solve!("The total number of unique successful shots is:", hits.count)
