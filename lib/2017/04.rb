PASSWORDS = INPUT.split("\n").map(&:split)

def valid_count(passwords)
  passwords.count do |words|
    words.none? { |word| words.count(word) > 1 }
  end
end

solve!("Number of valid passwords:", valid_count(PASSWORDS))

DEANAGRAMIZED_PASSWORDS = PASSWORDS.map { |row| row.map { |word| word.chars.sort.join } }

solve!("Number of valid passwords (no anagrams):", valid_count(DEANAGRAMIZED_PASSWORDS))
