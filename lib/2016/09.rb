def decompressed_length(input, recursive: false)
  index = 0
  length = 0

  loop do
    if input[index] == "("
      index += 1
      close_index = input[index..].index(")")
      metrics = input[index...(index + close_index)]

      gather, repeat = metrics.split("x").map(&:to_i)
      index += close_index

      sublength =
        if recursive
          decompressed_length(input[index...(index + gather)], recursive: true)
        else
          gather
        end

      index += gather
      length += repeat * sublength
    else
      length += 1
    end

    index += 1
    break unless index < input.length
  end

  length
end

puts "The decompressed length is:", decompressed_length(INPUT.chomp), nil
puts "The recursively decompressed length is:", decompressed_length(INPUT.chomp, recursive: true)
