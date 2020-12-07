class Keypad
  def initialize(layout)
    @layout = layout
    @y = layout.index { |row| row.include?("5") }
    @x = layout[@y].index("5")
  end

  def move_finger(direction)
    case direction
    when "U"
      @y -= 1 unless @y - 1 < 0 || @layout[@y - 1][@x].nil?
    when "D"
      @y += 1 unless @y + 1 >= @layout.length || @layout[@y + 1][@x].nil?
    when "L"
      @x -= 1 unless @x - 1 < 0 || @layout[@y][@x - 1].nil?
    when "R"
      @x += 1 unless @x + 1 >= @layout[@y].length || @layout[@y][@x + 1].nil?
    end
  end

  def current_key
    @layout[@y][@x]
  end
end

def code(keypad)
  INPUT.split("\n").map do |line|
    line.chars.each { |direction| keypad.move_finger(direction) }
    keypad.current_key
  end.join
end

standard_keypad = Keypad.new(
  [
    %w[1 2 3],
    %w[4 5 6],
    %w[7 8 9],
  ],
)

solve!("The first keycode is:", code(standard_keypad))

wonky_keypad = Keypad.new(
  [
    [nil, nil, "1", nil, nil],
    [nil, "2", "3", "4", nil],
    %w[5 6 7 8 9],
    [nil, "A", "B", "C", nil],
    [nil, nil, "D", nil, nil],
  ],
)
solve!("The second keycode is:", code(wonky_keypad))
