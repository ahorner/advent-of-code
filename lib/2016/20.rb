def condense_ranges(ranges)
  ranges.sort_by(&:first).each_with_object([]) do |range, ips|
    (ips << range) and next if ips.empty?

    last_range = ips.last
    last_ip = last_range.last

    if last_ip + 1 < range.first
      ips << range
    else
      ending_ip = [last_ip, range.last].max
      ips[-1] = (last_range.first..ending_ip)
    end
  end
end

def missing_values(ranges)
  missing = []

  ranges.each_with_index do |range, i|
    next if i == ranges.length - 1

    lower_ip = range.last
    upper_ip = ranges[i + 1].first
    ((lower_ip + 1)...upper_ip).each { |ip| missing << ip }
  end

  missing
end

blacklist = []

INPUT.split("\n").each do |line|
  beginning, ending = line.split("-").map(&:to_i)
  blacklist << (beginning..ending)
end

blacklist = condense_ranges(blacklist)
valid_ips = missing_values(blacklist)

puts "The first valid IP address is:", valid_ips.first, nil
puts "The number of valid IP addresses is:", valid_ips.count
