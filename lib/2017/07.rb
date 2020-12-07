class Program
  attr_accessor :name, :weight, :children, :subprograms

  def initialize(name, weight, children = [])
    @name = name
    @weight = weight
    @children = children
    @subprograms = []
  end

  def total_weight
    @total_weight ||= @weight + @subprograms.inject(0) { |sum, s| sum + s.total_weight }
  end

  def corrected_weight
    weights = @subprograms.map(&:total_weight)
    outlier = weights.detect { |w| weights.count(w) == 1 }
    return if outlier.nil?

    faulty = @subprograms[weights.index(outlier)]
    weight = faulty.corrected_weight
    return weight if weight

    proper_weight = (weights - [outlier]).first
    weight_difference = outlier - proper_weight
    faulty.weight - weight_difference
  end
end

# rubocop:disable Lint/MixedRegexpCaptureTypes
PROGRAM_MATCHER = /(?<name>\w+) \((?<weight>\d+)\)( -> (?<children>.+))?/.freeze
# rubocop:enable Lint/MixedRegexpCaptureTypes

def stack(input)
  programs = {}

  input.split("\n").each do |row|
    match = row.match(PROGRAM_MATCHER)
    programs[match[:name]] = Program.new(
      match[:name],
      match[:weight].to_i,
      match[:children]&.split(", ") || [],
    )
  end

  names = programs.keys
  programs.each_value do |program|
    program.children.each do |child|
      names.delete(child)
      program.subprograms << programs[child]
    end
  end

  programs[names.first]
end

root = stack(INPUT)

solve!("The root program is:", root.name)
solve!("The expected weight for the faulty program is:", root.corrected_weight)
