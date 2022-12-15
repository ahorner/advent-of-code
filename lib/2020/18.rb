LINES = INPUT.split("\n")

class Expression
  OPERATIONS = {
    "+" => ->(a, b) { a + b },
    "*" => ->(a, b) { a * b }
  }.freeze

  def initialize(expression, precedence: {"*" => 2, "+" => 1})
    @expression = expression
    @precedence = precedence
  end

  def evaluate
    expression_stack.each_with_object([]) do |token, stack|
      stack.push(OPERATIONS.key?(token) ? OPERATIONS[token][*stack.pop(2)] : token)
    end.first
  end

  private

  def expression_stack
    @expression_stack ||= begin
      stack = []
      operators = []

      @expression.tr(" ", "").chars.each do |token|
        case token
        when *OPERATIONS.keys
          op2 = operators.last
          stack << operators.pop if OPERATIONS.key?(op2) && @precedence[token] <= @precedence[op2]
          operators << token
        when "("
          operators << token
        when ")"
          stack << operators.pop until operators.last == "("
          operators.pop
        else
          stack << token.to_i
        end
      end

      stack + operators.reverse
    end
  end
end

values = LINES.map { |line| Expression.new(line, precedence: {"*" => 1, "+" => 1}).evaluate }
solve!("The total with neutral-precedence operations is:", values.sum)

values = LINES.map { |line| Expression.new(line, precedence: {"*" => 1, "+" => 2}).evaluate }
solve!("The total with reverse-precedence operations is:", values.sum)
