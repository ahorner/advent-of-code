def look_and_say(string)
  string.gsub(/(.)\1*/) { |match| "#{match.size}#{match[0]}" }
end

def loop_and_say(string, times)
  times.times { string = look_and_say(string) }
  string
end

result = loop_and_say(INPUT, 40)
puts "After 40 iterations:", result.length, nil

result = loop_and_say(result, 10)
puts "After 50 iterations:", result.length
