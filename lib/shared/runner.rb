class Runner
  class SolutionFound < RuntimeError; end

  def self.reset!
    Object.send(:remove_const, "INPUT")
    (constants - [:SolutionFound]).each { |c| remove_const(c) }
  end

  def initialize(date, logger: StringIO.new)
    @date = date
    @logger = logger
  end

  def execute!(input, part: nil, **overrides)
    @part_number = part
    @solutions = []

    overrides.each { |key, value| self.class.const_set(key, value) }

    path = File.expand_path("../#{@date}.rb", File.dirname(__FILE__))
    eval(File.read(path), run_context(input.chomp("\n")).call, path) # rubocop:disable Security/Eval

    @solutions
  rescue SolutionFound
    @solutions[@part_number - 1]
  ensure
    self.class.reset!
  end

  private

  def solve!(*values)
    @solutions << values.last
    @logger.puts(*values, "\n")

    raise SolutionFound if @solutions.length == @part_number
  end

  def run_context(input)
    lambda do
      Object.const_set("INPUT", input)
      binding
    end
  end
end
