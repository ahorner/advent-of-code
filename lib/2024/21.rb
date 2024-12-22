require "matrix"

CODES = INPUT.split("\n")

DIRECTIONAL_LAYOUT = {
  Vector[1, 0] => "^", Vector[2, 0] => "A",
  Vector[0, 1] => "<", Vector[1, 1] => "v", Vector[2, 1] => ">"
}

NUMERIC_LAYOUT = {
  Vector[0, 0] => "7", Vector[1, 0] => "8", Vector[2, 0] => "9",
  Vector[0, 1] => "4", Vector[1, 1] => "5", Vector[2, 1] => "6",
  Vector[0, 2] => "1", Vector[1, 2] => "2", Vector[2, 2] => "3",
  Vector[1, 3] => "0", Vector[2, 3] => "A"
}

class Keypad
  def initialize(layout)
    @layout = layout
    @sequences = {}
  end

  def position(key)
    @layout.key(key)
  end

  def sequence(from, to)
    @sequences[[from, to]] ||= begin
      sequence = []

      p1 = position(from)
      p2 = position(to)

      move_x = p2[0] - p1[0]
      move_y = p2[1] - p1[1]

      if move_x < 0 && @layout.key?(p1 + Vector[move_x, 0])
        move_x.abs.times { sequence << "<" }
        move_y.abs.times { sequence << ((move_y < 0) ? "^" : "v") }
      elsif @layout.key?(p1 + Vector[0, move_y])
        move_y.abs.times { sequence << ((move_y < 0) ? "^" : "v") }
        move_x.abs.times { sequence << ((move_x < 0) ? "<" : ">") }
      else
        move_x.abs.times { sequence << ((move_x < 0) ? "<" : ">") }
        move_y.abs.times { sequence << ((move_y < 0) ? "^" : "v") }
      end

      sequence << "A"
      sequence.join
    end
  end
end

DIRECTIONAL_KEYPAD = Keypad.new(DIRECTIONAL_LAYOUT)
NUMERIC_KEYPAD = Keypad.new(NUMERIC_LAYOUT)

def directional_presses(code, robots, cache = {})
  cache[[code, robots]] ||= "A#{code}".chars.each_cons(2).sum do |a, b|
    sequence = DIRECTIONAL_KEYPAD.sequence(a, b)
    next sequence.length if robots == 0

    directional_presses(sequence, robots - 1, cache)
  end
end

def key_presses(code, robots)
  entry = "A#{code}".chars.each_cons(2).map { |a, b| NUMERIC_KEYPAD.sequence(a, b) }.join
  directional_presses(entry, robots - 1)
end

complexity = CODES.sum { |code| code.to_i * key_presses(code, 2) }
solve!("The total complexity of two-robot codes is:", complexity)

complexity = CODES.sum { |code| code.to_i * key_presses(code, 25) }
solve!("The total complexity of 25-robot codes is:", complexity)
