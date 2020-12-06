require_relative "../shared/assembunny"

def sequence(&generator)
  Enumerator.new do |yielder|
    n = 0
    loop do
      yielder.yield generator.call(n)
      n += 1
    end
  end
end

# There are a handful of false positives if you set this too low.
SIGNAL_CUTOFF = 8
CLOCK_SIGNAL = sequence { |i| i.even? ? 0 : 1 }.freeze

def run(start)
  registers = Hash.new(0).tap { |h| h["a"] = start }
  computer = Assembunny.new(registers)
  outputs = []

  computer.run(INSTRUCTIONS) do |output|
    outputs << output
    break if outputs != CLOCK_SIGNAL.take(outputs.length)
    break start if outputs.length == SIGNAL_CUTOFF
  end
end

start = nil
i = 0

while start.nil?
  start = run(i)
  i += 1
end

puts "The first number that initiates a clock sequence is:", start, nil
