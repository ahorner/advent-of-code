MATCHER = /(?<players>\d+) players; last marble is worth (?<points>\d+) points/

class Marble
  attr_accessor :next, :prev
  attr_reader :value

  def initialize(value)
    @value = value
    @next = self
    @prev = self
  end

  def add(marble)
    marble.prev = @next
    marble.next = @next.next
    @next.next.prev = marble
    @next.next = marble

    marble
  end

  def target
    @prev.prev.prev.prev.prev.prev.prev
  end

  def remove
    @next.prev = @prev
    @prev.next = @next

    @next
  end

  def special?
    value % 23 == 0
  end
end

def play(players, points)
  current_marble = Marble.new(0)
  scores = [0] * players

  current_player = 0

  (1..points).each do |value|
    marble = Marble.new(value)

    if marble.special?
      taken = current_marble.target
      current_marble = taken.remove

      scores[current_player] += marble.value + taken.value
    else
      current_marble = current_marble.add(marble)
    end

    current_player += 1
    current_player %= players
  end

  scores
end

data = INPUT.match(MATCHER)
results = play(data[:players].to_i, data[:points].to_i)
solve!("The winning elf's score is: ", results.max)

results = play(data[:players].to_i, data[:points].to_i * 100)
solve!("The winning elf's score in the longer round is:", results.max)
