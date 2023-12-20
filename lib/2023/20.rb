class Communication
  LOW = 0
  HIGH = 1

  attr_reader :inputs, :outputs, :pulses

  def initialize(outputs)
    @outputs = outputs
    @inputs = []
    @pulses = []
  end

  def register!(input)
    @inputs << input
  end
end

class Broadcast < Communication
  def transmit(_input, pulse)
    @pulses << pulse
    pulse
  end
end

class FlipFlop < Communication
  def transmit(_input, pulse)
    return if pulse == HIGH

    @active = !@active

    out = @active ? HIGH : LOW
    @pulses << out

    out
  end
end

class Conjunction < Communication
  def transmit(input, pulse)
    @last_signals ||= Hash.new(LOW)
    @last_signals[input] = pulse

    out = (inputs.all? { |i| @last_signals[i] == HIGH }) ? LOW : HIGH
    @pulses << out

    out
  end
end

MODULE_MATCHER = /\A(?<type>%|&)?(?<name>.+)\z/
CONFIGURATION = INPUT.split("\n").each_with_object({}) do |line, config|
  label, outputs = line.split(" -> ")

  outputs = outputs.split(", ")
  label_data = MODULE_MATCHER.match(label)

  config[label_data[:name]] =
    case label_data[:type]
    when "&" then Conjunction.new(outputs)
    when "%" then FlipFlop.new(outputs)
    else Broadcast.new(outputs)
    end
end

CONFIGURATION.each do |name, comm|
  comm.outputs.each { |output| CONFIGURATION[output]&.register!(name) }
end

def broadcast!(configuration)
  transmissions = [[nil, Communication::LOW, "broadcaster"]]
  pulses = [0, 0]

  loop do
    break if transmissions.empty?

    sender, pulse, receiver = transmissions.shift
    pulses[pulse] += 1

    transmitter = configuration[receiver]
    signal = transmitter&.transmit(sender, pulse)
    next unless signal

    transmitter.outputs.each { |output| transmissions << [receiver, signal, output] }
  end

  pulses
end

def deep_clone(configuration)
  Marshal.load(Marshal.dump(configuration))
end

def press!(configuration, times)
  configuration = deep_clone(configuration)
  pulses = times.times.map { broadcast!(configuration) }
  pulses.reduce { |a, b| a.zip(b).map(&:sum) }.reduce(:*)
end

solve!("The product of high and low pulse counts is:", press!(CONFIGURATION, 1000))

def presses_to(configuration, name, signal)
  configuration = deep_clone(configuration)
  count = 0

  loop do
    count += 1
    broadcast!(configuration)
    break count if configuration[name].pulses.include?(signal)
  end
end

RECEIVER = "rx"

transmitter = CONFIGURATION.values.detect { |comm| comm.outputs.include?(RECEIVER) }
presses = transmitter.inputs.map { |input| presses_to(CONFIGURATION, input, Communication::HIGH) }.reduce(&:lcm)

solve!("The minimum number of presses to activate the receiver is:", presses)
