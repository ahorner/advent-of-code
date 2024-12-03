REPORTS = INPUT.split("\n").map { |line| line.split.map(&:to_i) }

def safe?(report, tolerance: 0)
  variants = (tolerance > 0) ? report.combination(report.length - 1) : []

  unless report == report.sort || report == report.sort.reverse
    return variants.any? { |variant| safe?(variant, tolerance: tolerance - 1) }
  end

  min = Float::INFINITY
  max = -Float::INFINITY

  report.each_cons(2) do |a, b|
    gap = (a - b).abs
    min = [gap, min].min
    max = [gap, max].max
  end

  return variants.any? { |variant| safe?(variant, tolerance: tolerance - 1) } unless min >= 1 && max <= 3

  true
end

solve!(REPORTS.count { |report| safe?(report) })
solve!(REPORTS.count { |report| safe?(report, tolerance: 1) })
