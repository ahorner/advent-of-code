programs = Hash.new { |h, k| h[k] = [] }

INPUT.split("\n").each do |row|
  program, friends = row.split(" <-> ")
  friends = friends.split(", ")

  posse = ([program] + friends)
  posse.each do |item|
    programs[item] = programs[item].concat(posse).uniq
  end
end

def group(programs, index, seen = [])
  seen = seen.dup

  friends = programs[index] - seen

  # rubocop:disable Style/CombinableLoops
  friends.each { |program| seen << program }
  friends.each { |program| seen = group(programs, program, seen) }
  # rubocop:enable Style/CombinableLoops

  seen
end

solve!("The number of programs in 0's group is:", group(programs, "0").count)

groups = []

while programs.count > 0
  groups << group(programs, programs.keys.first)
  programs = programs.except(*groups.last)
end

solve!("The total number of groups is:", groups.count)
