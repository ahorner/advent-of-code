times, distances = INPUT.split("\n")
TIMES = times.scan(/\d+/).map(&:to_i)
RECORDS = distances.scan(/\d+/).map(&:to_i)

def distance_for(t, time)
  (time - t) * t
end

def strategies_for(time, distance)
  min = distance / time
  min += 1 until distance_for(min, time) > distance

  max = time
  max -= 1 until distance_for(max, time) > distance

  max - min + 1
end

strategies = TIMES.zip(RECORDS).map { |time, distance| strategies_for(time, distance) }
solve!("The product of winning strategies is:", strategies.reduce(:*))

TIME = times.gsub(/\D+/, "").to_i
RECORD = distances.gsub(/\D+/, "").to_i

solve!("The long-run winning strategy count is:", strategies_for(TIME, RECORD))
