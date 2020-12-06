EXPECTED_READINGS = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1,
}.freeze

def parse(lines)
  lines.map do |line|
    readings = line.scan(/(\w+): (\d)/).flat_map do |(reading, value)|
      [reading.to_sym, value.to_i]
    end

    Hash[*readings]
  end
end

def correct_sue(sues, validity_checker = :valid?)
  matches = EXPECTED_READINGS.reduce(sues) do |remaining, (reading, value)|
    remaining.select { |sue| send(validity_checker, reading, value, sue) }
  end

  sues.index(matches.first) + 1
end

def valid?(reading, value, sue)
  sue[reading].nil? || sue[reading] == value
end

sues = parse(INPUT.split("\n"))
puts "The number of the correct Sue:", correct_sue(sues), nil

def valid_with_adjustments?(reading, value, sue)
  return true if sue[reading].nil?

  case reading
  when :cats, :trees
    sue[reading] > value
  when :pomeranians, :goldfish
    sue[reading] < value
  else
    sue[reading] == value
  end
end

puts "The number of the correct Sue (with adjustments):", correct_sue(sues, :valid_with_adjustments?)
