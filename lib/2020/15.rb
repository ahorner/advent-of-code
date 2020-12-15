STARTING_NUMBERS = INPUT.split(",").map(&:to_i).freeze

def speak(starting_numbers, rounds)
  indices = Hash.new { |h, k| h[k] = [] }
  starting_numbers.each_with_index { |n, i| indices[n] << i }
  last_num = starting_numbers.last

  (starting_numbers.size...rounds).each do |i|
    number =
      if indices[last_num].length > 1
        indices[last_num][-1] - indices[last_num][-2]
      else
        0
      end

    last_num = number
    indices[number] << i
  end

  last_num
end

ROUNDS = 2_020
solve!("The #{ROUNDS}th number spoken is:", speak(STARTING_NUMBERS, ROUNDS))

NEW_ROUNDS = 30_000_000
solve!("The #{NEW_ROUNDS}th number spoken is:", speak(STARTING_NUMBERS, NEW_ROUNDS))
