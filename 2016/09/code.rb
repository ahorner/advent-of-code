def decompressed_length(input, recursive = false)
  index = 0
  length = 0

  begin
    if input[index] == "("
      index += 1
      close_index = input[index..-1].index(")")
      metrics = input[index...(index + close_index)]

      gather, repeat = metrics.split("x").map(&:to_i)
      index += close_index

      sublength =
        if recursive
          decompressed_length(input[index...(index + gather)], true)
        else
          gather
        end

      index += gather
      length += repeat * sublength
    else
      length += 1
    end

    index += 1
  end while index < input.length

  length
end

puts "The decompressed length is:", decompressed_length(INPUT.chomp), nil
puts "The recursively decompressed length is:", decompressed_length(INPUT.chomp, true)
