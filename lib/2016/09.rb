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
          next_index = (index + 1)
          decompressed_length(input[next_index...(next_index + gather)], recursive: true)
        else
          gather
        end

      index += gather
      length += repeat * sublength
    else
      length += 1
    end

    index += 1
    break if index >= input.length
  end

  length
end

solve!("The decompressed length is:", decompressed_length(INPUT))
solve!("The recursively decompressed length is:", decompressed_length(INPUT, recursive: true))
