SIGNAL = INPUT.split("").map(&:to_i)
BASE_PATTERN = [0, 1, 0, -1].freeze

def fft(signal)
  signal.length.times.map do |position|
    signal.each_with_index.sum { |n, i| n * pattern_for(position, i) }.abs % 10
  end
end

def pattern_for(position, index)
  BASE_PATTERN[((index + 1) / (position + 1)) % BASE_PATTERN.length]
end

signal = SIGNAL.dup
100.times { signal = fft(signal) }

puts "The first eight digits are:", signal.first(8).join, "\n"

def partial_fft(signal)
  partial_sum = signal.sum
  signal.length.times.map do |i|
    value = partial_sum.abs % 10
    partial_sum -= signal[i]
    value
  end
end

offset = SIGNAL.first(7).join.to_i
signal = (SIGNAL * 10_000)[offset..-1]
100.times { |_i| signal = partial_fft(signal) }

puts "The eight-digit message is:", signal.first(8).join
