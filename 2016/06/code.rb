counts = []

INPUT.split("\n").each do |line|
  line.chars.each_with_index do |char, index|
    counts[index] ||= Hash.new(0)
    counts[index][char] += 1
  end
end

password = counts.map { |count| count.keys.max_by { |c| count[c] } }
puts "The password by most common character is:", password.join, nil

password = counts.map { |count| count.keys.min_by { |c| count[c] } }
puts "The password by least common character is:", password.join, nil
