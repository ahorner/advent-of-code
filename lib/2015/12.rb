require "json"

input = JSON.parse(INPUT)

def deep_sum(object, ignore: nil)
  case object
  when Array
    object.map { |i| deep_sum(i, ignore: ignore) }.sum
  when Hash
    return 0 if object.values.include?(ignore)

    deep_sum(object.values, ignore: ignore)
  else
    object.to_i
  end
end

solve!("Total Value: ", deep_sum(input))
solve!("Total Adjusted Value: ", deep_sum(input, ignore: "red"))
