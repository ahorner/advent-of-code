class Runner
  def self.reset!
    Object.send(:remove_const, "INPUT")
    constants.each { |c| remove_const(c) }
  end

  def initialize(date, logger: StringIO.new)
    @date = date
    @logger = logger
    @solutions = []
  end

  def execute!(input)
    path = File.expand_path("../#{@date}.rb", File.dirname(__FILE__))
    eval(File.read(path), run_context(input).call, path) # rubocop:disable Security/Eval

    @solutions
  ensure
    self.class.reset!
  end

  private

  def solve!(*values)
    @solutions << values.last
    @logger.puts(*values, "\n")
  end

  def run_context(input)
    lambda do
      Object.const_set("INPUT", input)
      binding
    end
  end
end
