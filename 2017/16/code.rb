MOVES = INPUT.split(",")
DANCERS = %w[a b c d e f g h i j k l m n o p]

def dance(performances = 1)
  dancers = DANCERS.dup
  positions = []
  positions << dancers.dup

  performances.times do
    MOVES.each do |move|
      case move
      when /s(\d+)/
        steps = Regexp.last_match[1].to_i
        dancers = dancers.rotate(-steps)
      when /x(\d+)\/(\d+)/
        first = Regexp.last_match[1].to_i
        second = Regexp.last_match[2].to_i
        dancers[first], dancers[second] = dancers[second], dancers[first]
      when /p(.+)\/(.+)/
        first = dancers.index(Regexp.last_match[1])
        second = dancers.index(Regexp.last_match[2])
        dancers[first], dancers[second] = dancers[second], dancers[first]
      end
    end

    break if positions.include?(dancers)
    positions << dancers.dup
  end

  positions[performances % positions.length].join
end

puts "The order of dancers after their performance is:", dance, nil
puts "The order of dancers after one billion performances is:", dance(1_000_000_000)

