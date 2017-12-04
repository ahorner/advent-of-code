PASSWORDS = INPUT.split("\n").map { |row| row.split(" ") }

def valid_count(passwords)
  passwords.count do |words|
    words.none? { |word| words.count(word) > 1 }
  end
end

puts "Number of valid passwords:", valid_count(PASSWORDS), nil

DEANAGRAMIZED_PASSWORDS = PASSWORDS.map { |row| row.map { |word| word.chars.sort.join } }

puts "Number of valid passwords (no anagrams):", valid_count(DEANAGRAMIZED_PASSWORDS)
