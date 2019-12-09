require_relative "../shared/intcode"

def amplify(phase_settings)
  signal = 0
  amplifiers = phase_settings.map do |setting|
    Computer.new(INTCODE).tap { |cpu| cpu.run(inputs: [setting]) }
  end

  loop do
    amplifiers.each { |amplifier| signal = amplifier.run(inputs: [signal]).last }
    break if amplifiers.none?(&:running?)
  end

  signal
end

def optimal_signal(phases)
  phases.permutation.to_a.map { |phase_settings| amplify(phase_settings) }.max
end

puts "The maximum thruster signal is:", optimal_signal([0, 1, 2, 3, 4]), "\n"
puts "The maximum feedback loop thruster signal is:", optimal_signal([5, 6, 7, 8, 9])
