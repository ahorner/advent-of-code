DATA_STREAM = INPUT.chars.to_a

def processed_characters(buffer, marker_length)
  buffer.each_cons(marker_length).each_with_index do |marker, i|
    break i + marker_length if marker.uniq.count == marker_length
  end
end

solve!(
  "The number of characters processed before the first start-of-packet marker is:",
  processed_characters(DATA_STREAM, 4)
)

solve!(
  "The number of characters processed before the first start-of-message marker is:",
  processed_characters(DATA_STREAM, 14)
)
