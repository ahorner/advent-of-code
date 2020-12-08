def look_and_say(string)
  string.gsub(/(.)\1*/) { |match| "#{match.size}#{match[0]}" }
end

def loop_and_say(string, times)
  times.times { string = look_and_say(string) }
  string
end

TIMES ||= 40
result = loop_and_say(INPUT, TIMES)
solve!("After 40 iterations:", result.length)

result = loop_and_say(result, 10)
solve!("After 50 iterations:", result.length)
