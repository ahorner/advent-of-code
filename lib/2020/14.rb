LINES = INPUT.split("\n")

MASK_MATCHER = /^mask = (?<mask>[01X]+)$/
INPUT_MATCHER = /^mem\[(?<address>\d+)\] = (?<value>\d+)$/

class InputMask
  def initialize(mask_string)
    @mask_string = mask_string
  end

  def apply(value)
    (value & zeroes) | ones
  end

  private

  def ones
    @ones ||= @mask_string.tr("X", "0").to_i(2)
  end

  def zeroes
    @zeroes ||= @mask_string.tr("X", "1").to_i(2)
  end
end

class AddressMask
  def initialize(mask_string)
    @mask_string = mask_string
  end

  def apply(address)
    address &= address_base
    address_masks.map { |address_mask| address | address_mask }
  end

  private

  def mask
    @mask ||= @mask_string.reverse.chars
  end

  def base_for(n)
    mask.each_with_index.reduce(0) { |base, (c, i)| (c == n) ? base | (1 << i) : base }
  end

  def address_base
    @address_base ||= base_for("0")
  end

  def mask_base
    @mask_base ||= base_for("1")
  end

  def address_masks
    @address_masks ||= begin
      floating_bits = mask.map.with_index { |c, i| i if c == "X" }.compact

      (0..(2**floating_bits.size)).map do |template|
        floating_bits.each_with_index.reduce(mask_base) do |address, (bit, index)|
          address | ((template & (1 << index)) << (bit - index))
        end
      end
    end
  end
end

def apply_masking(masker)
  memory = Hash.new(0)
  mask = nil

  LINES.each do |line|
    case line
    when MASK_MATCHER
      mask = masker.new($~[:mask])
    when INPUT_MATCHER
      yield memory, mask, $~
    end
  end

  memory
end

final = apply_masking(InputMask) do |memory, mask, data|
  memory[data[:address].to_i] = mask.apply(data[:value].to_i)
end

solve!("The sum of values in memory after input masking is:", final.values.sum)

final = apply_masking(AddressMask) do |memory, mask, data|
  mask.apply(data[:address].to_i).each { |address| memory[address] = data[:value].to_i }
end

solve!("The sum of values in memory after address masking is:", final.values.sum)
