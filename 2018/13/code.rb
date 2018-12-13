class Cart
  CHOICES = %i[left straight right].freeze

  attr_reader :x, :y

  def initialize(x, y, dx, dy)
    @x, @y, @dx, @dy = x, y, dx, dy
    @choices = 0
  end

  def tick!(grid)
    @x += @dx
    @y += @dy

    case grid[@y][@x]
    when "/" then @dx, @dy = -@dy, -@dx
    when "\\" then @dx, @dy = @dy, @dx
    when "+"
      case CHOICES[@choices % CHOICES.size]
      when :left then @dx, @dy = @dy, -@dx
      when :right then @dx, @dy = -@dy, @dx
      end

      @choices += 1
    end
  end
end

ROWS = INPUT.split("\n")

grid = Array.new(ROWS.size) { Array.new(ROWS.max_by(&:size).size) { " " } }
carts = []

ROWS.each_with_index do |row, y|
  row.chars.each_with_index do |c, x|
    grid[y][x], cart =
      case c
      when "<" then ["-", Cart.new(x, y, -1, 0)]
      when ">" then ["-", Cart.new(x, y, 1, 0)]
      when "^" then ["|", Cart.new(x, y, 0, -1)]
      when "v" then ["|", Cart.new(x, y, 0, 1)]
      else [c, nil]
      end
    carts << cart if cart
  end
end

first_crash = nil

loop do
  carts.dup.each do |cart|
    cart.tick!(grid)

    crash = (carts - [cart]).detect { |c| cart.x == c.x && cart.y == c.y }
    next unless crash

    first_crash ||= cart
    carts.delete(cart)
    carts.delete(crash)
  end

  break if carts.size <= 1
  carts.sort_by! { |cart| [cart.y, cart.x] }
end

puts "The first collision happens at:", [first_crash.x, first_crash.y].join(","), nil
puts "The last remaining cart is at:", [carts.last.x, carts.last.y].join(",")
