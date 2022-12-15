class Runner
  class SolutionFound < RuntimeError; end

  def initialize(date, logger: StringIO.new)
    @date = date
    @logger = logger
  end

  def execute!(input, part: nil, **overrides)
    @part_number = part
    read, write = IO.pipe

    Process.wait(fork do
      read.close
      @solutions = []
      overrides.each { |key, value| self.class.const_set(key, value) }

      path = File.expand_path("./#{@date}.rb", File.dirname(__FILE__))
      eval(File.read(path), run_context(input.chomp).call, path)

      Marshal.dump(@solutions, write)
    rescue SolutionFound
      Marshal.dump(@solutions[@part_number - 1], write)
    ensure
      write.close
    end)

    write.close
    Marshal.load(read.read)
  ensure
    read.close
  end

  private

  def solve!(*values)
    @solutions << values.last
    @logger.puts(*values, "\n")

    raise SolutionFound if @solutions.length == @part_number
  end

  def run_context(input)
    lambda do
      Object.const_set(:INPUT, input)
      binding
    end
  end
end
