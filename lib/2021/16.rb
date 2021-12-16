BITS = INPUT.chars.map { |c| format("%04b", c.to_i(16)) }.join

class Packet
  def initialize(stream)
    @stream = stream
    @cursor = 0
  end

  def read(length)
    value = @stream[@cursor, length]
    @cursor += length

    value
  end

  def value(length)
    read(length).to_i(2)
  end

  def end?
    @cursor >= @stream.length - 1
  end
end

class Transmission
  attr_reader :packet

  Signal = Struct.new(:version, :value)

  CALCULATIONS = {
    0 => ->(signals) { signals.sum(&:value) },
    1 => ->(signals) { signals.map(&:value).inject(:*) },
    2 => ->(signals) { signals.map(&:value).min },
    3 => ->(signals) { signals.map(&:value).max },
    5 => ->(signals) { signals[0].value > signals[1].value ? 1 : 0 },
    6 => ->(signals) { signals[0].value < signals[1].value ? 1 : 0 },
    7 => ->(signals) { signals[0].value == signals[1].value ? 1 : 0 },
  }.freeze

  def initialize(packet)
    @packet = packet
  end

  def signal
    version = packet.value(3)
    type_id = packet.value(3)

    case type_id
    when 4
      Signal.new(version, literal)
    else
      signals = subpackets

      Signal.new(
        version + signals.sum(&:version),
        CALCULATIONS[type_id].call(signals),
      )
    end
  end

  private

  def literal
    value = ""

    loop do
      continue = packet.value(1) == 1
      value << packet.read(4)

      break value.to_i(2) unless continue
    end
  end

  def subpackets
    case packet.value(1)
    when 0
      length = packet.value(15)
      subpacket = Packet.new(packet.read(length))

      collection = []
      collection << Transmission.new(subpacket).signal until subpacket.end?
      collection
    when 1
      packet.value(11).times.map { signal }
    end
  end
end

signal = Transmission.new(Packet.new(BITS)).signal
solve!("The version sum of the transmission is:", signal.version)
solve!("The outer value of the transmission is:", signal.value)
