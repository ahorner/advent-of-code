require_relative "./shared/intcode"

NETWORK = 50.times.map { |id| Computer.new(INTCODE).tap { |c| c.run(inputs: [id]) } }.freeze
NAT_ADDRESS = 255

queues = Hash.new { |h, k| h[k] = [] }
nat = []
last_y = nil

loop do
  NETWORK.each_with_index do |computer, id|
    outputs = computer.run(inputs: queues[id].shift || [-1])
    outputs.each_slice(3) do |address, x, y|
      address == NAT_ADDRESS ? nat << [x, y] : queues[address] << [x, y]
    end
  end

  next unless queues.values.all?(&:empty?)
  break if nat.last[1] == last_y

  last_y = nat.last[1]
  queues[0] << nat.last.dup
end

puts "The first Y value passed to the NAT is:", nat.first[1], "\n"
puts "The first Y value delivered by the NAT twice in a row is:", last_y
