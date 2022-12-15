class Generator
  DIVISOR = 2_147_483_647

  def initialize(start, factor, check = 1)
    @current = start
    @factor = factor
    @check = check
  end

  def next
    loop do
      @current = (@current * @factor) % DIVISOR
      break @current if @current % @check == 0
    end
  end
end

FACTORS = {
  a: 16_807,
  b: 48_271
}.freeze

CHECK_MASK = (1 << 16) - 1

start_values = {}
INPUT.split("\n").each do |line|
  match = line.match(/^Generator (?<name>.) starts with (?<start>\d+)$/)
  start_values[match[:name].downcase.to_sym] = match[:start].to_i
end

def match?(a, b)
  a & CHECK_MASK == b & CHECK_MASK
end

def match_count(a, b, checks)
  count = 0
  checks.times do
    count += 1 if match?(a.next, b.next)
  end
  count
end

a = Generator.new(start_values[:a], FACTORS[:a])
b = Generator.new(start_values[:b], FACTORS[:b])

CHECKS ||= 40_000_000
solve!("The judge's count after 40,000,000 checks is:", match_count(a, b, CHECKS))

a = Generator.new(start_values[:a], FACTORS[:a], 4)
b = Generator.new(start_values[:b], FACTORS[:b], 8)

solve!("The judge's count after 5,000,000 picky checks is:", match_count(a, b, 5_000_000))
