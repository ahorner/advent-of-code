class Firewall
  def initialize(_input)
    @layers = Hash.new(0)
    INPUT.split("\n").each do |layer|
      depth, range = layer.split(": ").map(&:to_i)
      @layers[depth] = range
    end
  end

  def traverse(delay = 0)
    depth = 0
    while depth <= max_depth
      yield depth, @layers[depth] if scanned?(depth, depth + delay)
      depth += 1
    end

    true
  end

  def scanned?(depth, time)
    return false unless @layers.key?(depth)

    time % ((@layers[depth] * 2) - 2) == 0
  end

  def max_depth
    @max_depth ||= @layers.keys.max
  end
end

firewall = Firewall.new(INPUT)

severity = 0
firewall.traverse { |depth, range| severity += depth * range }

solve!("The severity of traversing the firewall immediately is:", severity)

delay = 0

loop do
  delay += 1
  success = firewall.traverse(delay) { break false }
  break if success
end

solve!("The minimum delay to traverse the firewall undetected is:", delay)
