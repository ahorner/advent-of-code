order, *boards = INPUT.split("\n\n")

DRAW_ORDER = order.split(",").map(&:to_i).freeze
BOARDS = boards.freeze

class Board
  def initialize(board)
    @numbers = board.split("\n").map { |row| row.scan(/\d+/).map(&:to_i) }

    @height = @numbers.length
    @width = @numbers.first.length

    @marks = Array.new(@height) { Array.new(@width) }
  end

  def mark!(number)
    @height.times do |i|
      @width.times do |j|
        next unless @numbers[i][j] == number

        @marks[i][j] = true
        return true
      end
    end
  end

  def solved?
    @marks.any?(&:all?) || @width.times.any? { |i| @marks.all? { |row| row[i] } }
  end

  def score
    @height.times.sum do |i|
      @width.times.sum { |j| @marks[i][j] ? 0 : @numbers[i][j] }
    end
  end
end

participants = BOARDS.map { |b| Board.new(b) }
scores = DRAW_ORDER.each_with_object([]) do |number, scores|
  participants.each { |p| p.mark!(number) }
  winners, participants = participants.partition(&:solved?)
  winners.each { |board| scores << (board.score * number) }
end

solve!("The score of the winning board is:", scores.first)
solve!("The score of the losing board is:", scores.last)
