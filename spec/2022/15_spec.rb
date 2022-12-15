require "spec_helper"

RSpec.describe "Day 15: Beacon Exclusion Zone" do
  let(:runner) { Runner.new("2022/15") }
  let(:input) do
    <<~TXT
      Sensor at x=2, y=18: closest beacon is at x=-2, y=15
      Sensor at x=9, y=16: closest beacon is at x=10, y=16
      Sensor at x=13, y=2: closest beacon is at x=15, y=3
      Sensor at x=12, y=14: closest beacon is at x=10, y=16
      Sensor at x=10, y=20: closest beacon is at x=10, y=16
      Sensor at x=14, y=17: closest beacon is at x=10, y=16
      Sensor at x=8, y=7: closest beacon is at x=2, y=10
      Sensor at x=2, y=0: closest beacon is at x=2, y=10
      Sensor at x=0, y=11: closest beacon is at x=2, y=10
      Sensor at x=20, y=14: closest beacon is at x=25, y=17
      Sensor at x=17, y=20: closest beacon is at x=21, y=22
      Sensor at x=16, y=7: closest beacon is at x=15, y=3
      Sensor at x=14, y=3: closest beacon is at x=15, y=3
      Sensor at x=20, y=1: closest beacon is at x=15, y=3
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, ROW: 10) }

    it "finds the number of positions where a beacon cannot be present" do
      expect(solution).to eq(26)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2, ROW: 10, SEARCH_SPACE: 20) }

    it "finds the tuning frequency of the distress beacon" do
      expect(solution).to eq(56_000_011)
    end
  end
end
