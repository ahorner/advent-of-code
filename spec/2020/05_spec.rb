require "spec_helper"

describe "Day 5: Binary Boarding" do
  let(:runner) { Runner.new("2020/05") }

  describe "Part One" do
    it "calculates proper Seat IDs" do
      expect(runner.execute!("FBFBBFFRLR", part: 1)).to eq(357)
      expect(runner.execute!("BFFFBBFRRR", part: 1)).to eq(567)
      expect(runner.execute!("FFFBBBFRRR", part: 1)).to eq(119)
      expect(runner.execute!("BBFFBBFRLL", part: 1)).to eq(820)
    end
  end
end
