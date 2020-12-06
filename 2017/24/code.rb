class Bridge
  COMPONENTS = INPUT.split("\n").map { |l| l.split("/").map(&:to_i) }

  def initialize(components = [], open_port = 0)
    @components = components
    @open = open_port
  end

  def extended_with(component)
    Bridge.new(
      @components + [component],
      component[0] == @open ? component[1] : component[0],
    )
  end

  def extended_by?(component)
    component.include?(@open)
  end

  def strength
    @components.map(&:sum).sum
  end

  def length
    @components.size
  end

  def possibilities(components = COMPONENTS)
    valid_components = components.select { |c| extended_by?(c) }
    return [self] unless valid_components.any?

    valid_components.flat_map do |c|
      extended_with(c).possibilities(components - [c])
    end
  end
end

bridges = Bridge.new.possibilities
puts "The maximum bridge strength is:", bridges.max_by(&:strength).strength, nil

_max_length, long_bridges = bridges.group_by(&:length).max
puts "The strength of the longest bridge is:", long_bridges.max_by(&:strength).strength
