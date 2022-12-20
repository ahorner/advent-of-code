class EncryptedFile
  COORDS = [1000, 2000, 3000]

  Number = Struct.new(:value, :position)

  def initialize(values)
    @numbers = values.map.with_index { |v, i| Number.new(v, i) }
    @order = @numbers.dup
  end

  def mix!(times = 1)
    times.times do
      @order.each do |number|
        @numbers.rotate!(@numbers.index(number))
        @numbers.shift
        @numbers.rotate!(number.value)
        @numbers.unshift(number)
      end
    end
  end

  def coords
    values = @numbers.map(&:value)
    i = values.index(0)

    COORDS.map { |c| values[(i + c) % values.size] }
  end
end

NUMBERS = INPUT.split("\n").map(&:to_i)
file = EncryptedFile.new(NUMBERS)
file.mix!

solve!(
  "The sum of the grove coordinates is:",
  file.coords.sum
)

DECRYPTION_KEY = 811589153
file = EncryptedFile.new(NUMBERS.map { |n| n * DECRYPTION_KEY })
file.mix!(10)

solve!(
  "The sum of the decrypted grove coordinates is:",
  file.coords.sum
)
