class MonkeyBunch
  MONKEY_MATCHER = /^(?<name>[a-z]+): (?<job>.+)$/
  JOB_MATCHER = /^(?<first>[a-z]+) (?<operand>.) (?<second>[a-z]+)$/
  NUMBER_MATCHER = /^[0-9]+/

  def initialize(monkeys)
    @jobs = monkeys.to_h do |monkey|
      data = MONKEY_MATCHER.match(monkey)
      [data[:name], data[:job]]
    end

    @results = {}
  end

  def [](name)
    @results[name] = begin
      case @jobs[name]
      when JOB_MATCHER
        operate($~[:operand], self[$~[:first]], self[$~[:second]])
      when NUMBER_MATCHER
        @jobs[name].to_i
      end
    end
  end

  def value_for(name)
    yells = results
    friends = connected_to(name)
    test_from = "root"
    value = nil

    loop do
      break value if test_from == name

      job = JOB_MATCHER.match(@jobs[test_from])
      known, test_from, pos =
        if friends.include?(job[:first])
          [yells[job[:second]], job[:first], 1]
        else
          [yells[job[:first]], job[:second], 2]
        end

      value = value ? invert(job[:operand], value, known, pos) : known
    end
  end

  private

  def operate(operand, i, j)
    case operand
    when "+" then i + j
    when "-" then i - j
    when "*" then i * j
    when "/" then i / j
    end
  end

  def invert(operand, final, n, pos)
    case operand
    when "+" then final - n
    when "-" then (pos == 1) ? final + n : n - final
    when "*" then final / n
    when "/" then (pos == 1) ? final * n : n / final
    end
  end

  def results
    @results = {}
    self["root"]

    @results
  end

  def connected_to(name)
    original = @jobs[name]

    initial = results
    @jobs[name] = "0"
    changed = results

    @jobs[name] = original

    changed.keys.select { |k| changed[k] != initial[k] }
  end
end

bunch = MonkeyBunch.new(INPUT.split("\n"))
solve!(
  "The root monkey yells:",
  bunch["root"]
)
solve!(
  "To make the root monkey happy, you should yell:",
  bunch.value_for("humn")
)
