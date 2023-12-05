require "spec_helper"

RSpec.describe "Day 5: If You Give A Seed A Fertilizer" do
  let(:runner) { Runner.new("2023/05") }
  let(:input) do
    <<~TXT
      seeds: 79 14 55 13

      seed-to-soil map:
      50 98 2
      52 50 48

      soil-to-fertilizer map:
      0 15 37
      37 52 2
      39 0 15

      fertilizer-to-water map:
      49 53 8
      0 11 42
      42 0 7
      57 7 4

      water-to-light map:
      88 18 7
      18 25 70

      light-to-temperature map:
      45 77 23
      81 45 19
      68 64 13

      temperature-to-humidity map:
      0 69 1
      1 0 69

      humidity-to-location map:
      60 56 37
      56 93 4
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the lowest location number corresponding to a seed" do
      expect(solution).to eq(35)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the lowest location number for ranges of seeds" do
      expect(solution).to eq(46)
    end
  end
end
