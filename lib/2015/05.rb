LIST = INPUT.split("\n")

def nice?(line)
  vowels = line.scan(/[aeiou]/).count >= 3
  double_char = (line =~ /(.)\1+/)
  bad_words = (line =~ /ab|cd|pq|xy/)

  !!(vowels && double_char && !bad_words)
end

nice = LIST.select { |line| nice?(line) }
solve!("Making a list:", nice.size)

def still_nice?(line)
  matching_pairs = (line =~ /(..).*\1/)
  sandwich = (line =~ /(.).\1/)

  !!(matching_pairs && sandwich)
end

nice = LIST.select { |line| still_nice?(line) }
solve!("Checking it twice:", nice.size)
