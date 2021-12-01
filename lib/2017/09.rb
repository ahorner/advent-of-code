STREAM = INPUT.chars

group_score = 0
garbage_score = 0

open_groups = 0
garbage = false
ignore = false

STREAM.each do |c|
  if garbage && ignore
    ignore = false
    next
  end

  garbage_score += 1 if garbage && !%w[> !].include?(c)

  case c
  when "<"
    garbage = true
  when ">"
    garbage = false
  when "!"
    ignore = true if garbage
  when "{"
    next if garbage

    open_groups += 1
    group_score += open_groups
  when "}"
    next if garbage

    open_groups -= 1 if open_groups > 0
  end
end

solve!("The number of points from groups is:", group_score)
solve!("The number of garbage characters is:", garbage_score)
