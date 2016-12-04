MATCHER = /\A(?<code>.*)-(?<sector_id>[0-9]+)\[(?<checksum>.*)\]\z/.freeze
ALPHABET = ("a".."z").to_a.freeze
TARGET_ROOM = "northpoleobjectstorage".freeze

def real?(key, counts)
  highest = []
  alphabet = counts.keys.sort

  key.length.times do
    highest << alphabet.max_by { |i| counts[i] }
    alphabet -= [highest.last]
  end

  highest.all?{ |c| key.include?(c) }
end

def decrypt(code, shift)
  code.chars.map do |c|
    c == "-" ? " " : ALPHABET[(ALPHABET.index(c) + shift.to_i) % ALPHABET.size]
  end.join
end

vector_sums = 0
room_id = nil

INPUT.split("\n").each do |line|
  line = line.match(MATCHER)

  counts = Hash.new(0)
  line[:code].chars.each { |c| counts[c] += 1 unless c == "-" }

  if real?(line[:checksum], counts)
    vector_sums += line[:sector_id].to_i
    decrypted = decrypt(line[:code], line[:sector_id])
    room_id = line[:sector_id] if decrypted.delete(" ") == TARGET_ROOM
  end
end

puts "The sum of the real vector IDs is:", vector_sums, nil
puts "The vector ID of the North Pole Object Storage is:", room_id
