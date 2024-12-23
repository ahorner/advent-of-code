NETWORK = INPUT.split("\n").each_with_object(Hash.new { |h, k| h[k] = Set.new }) do |line, network|
  computer, connected = line.split("-")

  network[computer] << connected
  network[connected] << computer
end

def cliques(computer, network)
  network[computer].to_a.combination(2).select do |a, b|
    network[a].include?(b)
  end
end

parties = NETWORK.keys.each_with_object(Set.new) do |computer, lans|
  cliques(computer, NETWORK).each { |peers| lans << Set.new([computer, *peers]) }
end
matches = parties.count { |party| party.any? { |cpu| cpu.start_with?("t") } }

solve!("The number of groups containing a 't' computer is:", matches)

def largest_clique(network, clique = Set.new, ignore = Set.new)
  return clique if network.empty? && ignore.empty?

  network.keys.map do |computer|
    largest = largest_clique(
      network.slice(*network[computer]),
      clique + [computer],
      ignore.intersection(network[computer])
    )

    network.delete(computer)
    ignore << computer

    largest
  end.reject(&:nil?).max_by(&:size)
end

max_party = largest_clique(NETWORK.dup)
solve!("The LAN party password is:", max_party.sort.join(","))
