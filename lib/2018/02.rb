IDS = INPUT.split("\n")

twos = 0
threes = 0

IDS.each do |id|
  letters = id.chars.uniq
  twos += 1 if letters.any? { |l| id.count(l) == 2 }
  threes += 1 if letters.any? { |l| id.count(l) == 3 }
end

solve!("The final checksum is:", twos * threes)

def match?(first, second)
  matched_chars(first, second).size == first.size - 1
end

def matched_chars(first, second)
  matches = []

  first.chars.each_with_index do |c, i|
    matches << c if c == second[i]
  end

  matches.join
end

in_common = IDS.detect.with_index do |first, i|
  code = IDS.detect.with_index do |second, j|
    next if i >= j
    break matched_chars(first, second) if match?(first, second)
  end

  break code if code
end

solve!("The letters in common for the matching IDs are:", in_common)
