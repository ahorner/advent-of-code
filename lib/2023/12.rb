class Spring
  FOLDING_FACTOR = 5
  CONDITIONS = {
    operational: ".",
    damaged: "#",
    unknown: "?"
  }.freeze

  def initialize(record:, damage:)
    @record = record
    @damage = damage
    @arrangements = {}
  end

  def unfold(factor: FOLDING_FACTOR)
    record = ([@record] * factor).join(CONDITIONS[:unknown])
    damage = @damage * factor

    Spring.new(record:, damage:)
  end

  def arrangements(pattern = @record, splits = @damage)
    return @arrangements[[pattern, splits]] if @arrangements.key?([pattern, splits])
    return ((pattern&.chars || []).all? { |p| p != CONDITIONS[:damaged] }) ? 1 : 0 if splits.empty?

    damaged, *rest = splits
    after = rest.sum + rest.size

    @arrangements[[pattern, splits]] = (pattern.size - after - damaged + 1).times.sum do |before|
      candidate = [CONDITIONS[:operational]] * before + [CONDITIONS[:damaged]] * damaged + [CONDITIONS[:operational]]
      consistent?(candidate, pattern) ? arrangements(pattern[candidate.length..], rest) : 0
    end
  end

  def consistent?(candidate, pattern = @record)
    candidate.each_with_index.all? { |c, i| i > (pattern.length - 1) || pattern[i] == c || pattern[i] == CONDITIONS[:unknown] }
  end
end

SPRINGS = INPUT.split("\n").map do |line|
  record, damage = line.split(" ")
  damage = damage.split(",").map(&:to_i)

  Spring.new(record:, damage:)
end

total = SPRINGS.sum(&:arrangements)
solve!("The count of possible spring arrangements is:", total)

total = SPRINGS.map(&:unfold).sum(&:arrangements)
solve!("The count of possible unfolded spring arrangements is:", total)
