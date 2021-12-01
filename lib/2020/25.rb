INITIAL_SUBJECT = 7
MODULUS = 20_201_227
CARD_KEY, DOOR_KEY = INPUT.split("\n").map(&:to_i)
CARD_SECRET = (0..).reduce(1) do |value, loops|
  break loops if value == CARD_KEY # rubocop:disable Lint/UnmodifiedReduceAccumulator

  value * INITIAL_SUBJECT % MODULUS
end

encryption_key = CARD_SECRET.times.reduce(1) { |key, _| key * DOOR_KEY % MODULUS }
solve!("The encryption key is:", encryption_key)
