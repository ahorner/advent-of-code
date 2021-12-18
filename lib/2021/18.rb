class SnailfishNumber < Struct.new(:pair)
  EXPLODE_AT = 4
  SPLIT_AT = 10

  def +(other)
    number = [pair, other.pair]

    loop do
      changed, number, = explode(number)
      next if changed

      changed, number = split(number)
      break number unless changed
    end

    SnailfishNumber.new(number)
  end

  def magnitude(number = pair)
    number.is_a?(Numeric) ? number : (3 * magnitude(number[0])) + (2 * magnitude(number[1]))
  end

  private

  def explode(number, depth = 0)
    return [false, number, nil, nil] if number.is_a?(Numeric)
    return [true, 0, number[0], number[1]] if depth >= EXPLODE_AT

    changed, n, l, r = explode(number[0], depth + 1)
    return [true, [n, add_left(number[1], r)], l, nil] if changed

    changed, n, l, r = explode(number[1], depth + 1)
    return [true, [add_right(number[0], l), n], nil, r] if changed

    [false, number, nil, nil]
  end

  def split(number)
    case number
    when Numeric
      half = number / 2.0
      number >= SPLIT_AT ? [true, [half.floor, half.ceil]] : [false, number]
    else
      changed, n = split(number[0])
      return [true, [n, number[1]]] if changed

      changed, n = split(number[1])
      [changed, [number[0], n]]
    end
  end

  def add_left(number, v)
    return number if v.nil?

    number.is_a?(Numeric) ? number + v : [add_left(number[0], v), number[1]]
  end

  def add_right(number, v)
    return number if v.nil?

    number.is_a?(Numeric) ? number + v : [number[0], add_right(number[1], v)]
  end
end

SNAILFISH_NUMBERS = INPUT.split("\n").map { |line| SnailfishNumber.new(eval(line)) }

solve!("The magnitude of the final sum is:", SNAILFISH_NUMBERS.inject(:+).magnitude)
solve!(
  "The largest magnitude of any sum is:",
  SNAILFISH_NUMBERS.permutation(2).map { |a, b| (a + b).magnitude }.max,
)
