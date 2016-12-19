ELF_COUNT = INPUT.to_i

class Elf

  attr_accessor :gifts, :next, :prev, :number

  def initialize(number)
    @number = number
    @gifts = 1
    @next = nil
    @prev = nil
  end

  def take_from(elf)
    @gifts += elf.gifts
    elf.gifts = 0
    elf.prev.next = elf.next
    elf.next.prev = elf.prev
  end

end

def elf_ring
  first_elf = Elf.new(1)
  current_elf = first_elf

  ELF_COUNT.times.with_index(2) do |_, number|
    next_elf = Elf.new(number)

    current_elf.next = next_elf
    next_elf.prev = current_elf

    current_elf = next_elf
  end

  current_elf.next = first_elf
  first_elf.prev = current_elf

  first_elf
end

def take_from_next(start_with)
  current_elf = start_with

  while current_elf.next != current_elf
    current_elf.take_from(current_elf.next)
    current_elf = current_elf.next
  end

  current_elf
end

def take_from_across(start_with, elf_count)
  current_elf = start_with
  target = current_elf
  (elf_count/2).times { target = target.next }

  while current_elf.next != current_elf
    current_elf.take_from(target)
    elf_count -= 1

    target = ((elf_count % 2) == 1 ? target.next.next : target.next)
    current_elf = current_elf.next
  end

  current_elf
end

winner = take_from_next(elf_ring)
puts "The number of the last elf standing is:", winner.number, nil

winner = take_from_across(elf_ring, ELF_COUNT)
puts "The number of the last elf standing (advanced) is:", winner.number

