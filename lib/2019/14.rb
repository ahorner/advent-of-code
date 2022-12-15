REACTION_MATCHER = /\A(?<inputs>.+) => (?<output>.+)\z/
CHEMICAL_MATCHER = /(?<quantity>\d+) (?<name>.+)/

REACTIONS = INPUT.split("\n").each_with_object({}) do |line, reactions|
  reaction = line.match(REACTION_MATCHER)
  output = reaction[:output].match(CHEMICAL_MATCHER)
  inputs = reaction[:inputs].split(", ").map do |input|
    input = input.match(CHEMICAL_MATCHER)
    {name: input[:name], quantity: input[:quantity].to_i}
  end

  reactions[output[:name]] = {
    quantity: output[:quantity].to_i,
    inputs: inputs
  }
end

def ore_needed(chemical, quantity = 1)
  requirements = Hash.new(0)
  requirements[chemical] = quantity

  loop do
    chemical, quantity = requirements.detect { |name, quantity| name != "ORE" && quantity > 0 }

    reaction = REACTIONS[chemical]
    output = reaction[:quantity]
    batches = (quantity.to_f / output).ceil
    requirements[chemical] -= output * batches

    reaction[:inputs].each { |input| requirements[input[:name]] += input[:quantity] * batches }

    break if requirements.none? { |name, quantity| name != "ORE" && quantity > 0 }
  end

  requirements["ORE"]
end

solve!("The amount of ORE needed to produce 1 FUEL is:", ore_needed("FUEL"))

def maximum_output(chemical, ore)
  maximum = ore_needed(chemical)
  low = 0
  high = ore / maximum * 2

  loop do
    break if low >= high

    mid = ((low + high) / 2.0).ceil
    req = ore_needed(chemical, mid)
    (req > ore) ? high = mid - 1 : low = mid
  end

  low
end

solve!("The maximum amount of fuel you can product with 1 trillion ORE is:", maximum_output("FUEL", 1_000_000_000_000))
