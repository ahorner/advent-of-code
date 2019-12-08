PIXELS = INPUT.split("").map(&:to_i)
WIDTH = 25
HEIGHT = 6

LAYERS = PIXELS.each_slice(WIDTH * HEIGHT).to_a

min_layer = LAYERS.min_by { |layer| layer.count(0) }
puts "The layer checksum is:", min_layer.count(1) * min_layer.count(2), "\n"

OUTPUTS = { 0 => " ", 1 => "#" }.freeze
IMAGE = LAYERS.each_with_object(Array.new(WIDTH * HEIGHT)) do |layer, image|
  layer.each_with_index do |pixel, i|
    next if pixel == 2
    image[i] ||= pixel
  end
end

puts "The final image is:\n\n"

HEIGHT.times do |y|
  WIDTH.times { |x| print OUTPUTS[IMAGE[WIDTH * y + x]] }
  print "\n"
end
