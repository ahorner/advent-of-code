Range = Data.define(:source_start, :destination_start, :length) do
  def source?(n)
    source_start <= n && source_end >= n
  end

  def destination_for(n)
    destination_start + (n - source_start)
  end

  def source_end
    source_start + length
  end

  def destination_range(source_range)
    destination_for(source_range.begin)...destination_for(source_range.end)
  end
end

Map = Data.define(:source, :destination, :ranges) do
  def destination_for(n)
    range = ranges.detect { |r| r.source?(n) }
    range ? range.destination_for(n) : n
  end

  def destination_ranges(sources)
    ranges.each_with_object([]) do |range, mapped|
      sources = sources.each_with_object([]) do |source, unmapped|
        before = source.begin...[source.end, range.source_start].min
        overlap = [source.begin, range.source_start].max...[range.source_end, source.end].min
        after = [range.source_end, source.begin].max...source.end

        unmapped << before if before.end > before.begin
        unmapped << after if after.end > after.begin
        mapped << range.destination_range(overlap) if overlap.end > overlap.begin
      end
    end + sources
  end
end

seeds, *maps = INPUT.split("\n\n")

DESCRIPTION_MATCHER = /\A(?<source>\w+)-to-(?<destination>\w+) map:\z/
SEEDS = seeds.scan(/\d+/).map(&:to_i)
MAPS = maps.each_with_object({}) do |map, translations|
  description, *values = map.split("\n")
  info = description.match(DESCRIPTION_MATCHER)
  ranges = values.map do |line|
    d, s, l = line.split(" ").map(&:to_i)
    Range.new(
      source_start: s,
      destination_start: d,
      length: l
    )
  end

  translations[info[:source]] = Map.new(
    source: info[:source],
    destination: info[:destination],
    ranges:
  )
end

def locations_for(sources)
  type = "seed"

  loop do
    map = MAPS[type]
    type = map.destination
    sources = yield map, sources

    break sources if type == "location"
  end
end

locations = locations_for(SEEDS) { |map, sources| sources.map { |s| map.destination_for(s) } }
solve!("The minimum seed location is:", locations.min)

seeds = SEEDS.each_slice(2).map { |(a, b)| a...(a + b) }
ranges = locations_for(seeds) { |map, sources| map.destination_ranges(sources) }

solve!("The minimum location for seed ranges is:", ranges.map(&:begin).min)
