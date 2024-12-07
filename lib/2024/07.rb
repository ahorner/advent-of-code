LINE_MATCHER = /\A(?<value>\d+): (?<numbers>[0-9 ]+)\z/
TESTS = INPUT.split("\n").map do |line|
  match = line.match(LINE_MATCHER)
  {
    value: match[:value].to_i,
    numbers: match[:numbers].split.map(&:to_i)
  }
end
OPERATIONS = {
  "+": ->(a, b) { a + b },
  "*": ->(a, b) { a * b },
  "||": ->(a, b) { "#{a}#{b}".to_i }
}

def valid?(equation, operators)
  target = equation[:value]
  numbers = equation[:numbers].dup
  current_values = [numbers.shift]

  loop do
    break if numbers.empty?

    next_value = numbers.shift
    next_values = []

    operators.each do |operator|
      current_values.each do |value|
        result = OPERATIONS[operator].call(value, next_value)
        next_values << result if result <= target
      end
    end

    current_values = next_values
  end

  current_values.any? { |v| v == target }
end

calibrations = TESTS.select { |test| valid?(test, %i[+ *]) }
solve!("The calibration total is:", calibrations.sum { |c| c[:value] })

calibrations = TESTS.select { |test| valid?(test, %i[+ * ||]) }
solve!("The total with concatenation is:", calibrations.sum { |c| c[:value] })
