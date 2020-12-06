registers = Hash.new { |h, k| h[k] = 0 }
maximum = 0

# rubocop:disable Layout/LineLength
LINE_PARSER = /(?<register>\w+) (?<instruction>.+) (?<value>-?\d+) if (?<cregister>\w+) (?<comparison>.+) (?<cvalue>-?\d+)/.freeze
# rubocop:enable Layout/LineLength

INPUT.split("\n").each do |row|
  match = row.match(LINE_PARSER)
  next unless registers[match[:cregister]].send(match[:comparison], match[:cvalue].to_i)

  case match[:instruction]
  when "inc"
    registers[match[:register]] += match[:value].to_i
  when "dec"
    registers[match[:register]] -= match[:value].to_i
  end

  maximum = [maximum, registers[match[:register]]].max
end

puts "The highest value in a register after runtime is:", registers.values.max, nil
puts "The highest value ever held in a register was:", maximum
