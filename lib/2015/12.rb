require "json"

input = JSON.parse(INPUT)

def deep_sum(object, ignore: nil)
  case object
  when Array
    object.map { |i| deep_sum(i, ignore: ignore) }.inject(:+)
  when Hash
    return 0 if object.values.include?(ignore)

    deep_sum(object.values, ignore: ignore)
  else
    object.to_i
  end
end

puts "Total Value: ", deep_sum(input), nil
puts "Total Adjusted Value: ", deep_sum(input, ignore: "red")
