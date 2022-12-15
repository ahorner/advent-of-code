def condense_ranges(ranges)
  ranges.sort_by(&:first).each_with_object([]) do |range, ips|
    (ips << range) and next if ips.empty?

    last_range = ips.last
    last_ip = last_range.end

    if last_ip + 1 < range.begin
      ips << range
    else
      ending_ip = [last_ip, range.end].max
      ips[-1] = (last_range.begin..ending_ip)
    end
  end
end

def valid_ips(blocklist)
  missing = []

  blocklist.each_with_index do |range, i|
    next if i == blocklist.length - 1

    lower_ip = range.end
    upper_ip = blocklist[i + 1].first
    ((lower_ip + 1)...upper_ip).each { |ip| missing << ip }
  end

  beginning = (VALID_IPS.begin...blocklist.first.begin).to_a
  ending = ((blocklist.last.end + 1)..VALID_IPS.end).to_a

  beginning + missing + ending
end

VALID_IPS ||= (0..4_294_967_295)
BLOCKLIST = condense_ranges(INPUT.split("\n").map do |line|
  beginning, ending = line.split("-").map(&:to_i)
  (beginning..ending)
end)

safelist = valid_ips(BLOCKLIST)
solve!("The first valid IP address is:", safelist.first)
solve!("The number of valid IP addresses is:", safelist.count)
