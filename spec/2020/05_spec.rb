require "spec_helper"

describe "Day 5: Binary Boarding" do
  let(:runner) { Runner.new("2020/05") }

  describe "Part One" do
    it "calculates proper Seat IDs" do
      expect(runner.execute!("FBFBBFFRLR")).to include 357
      expect(runner.execute!("BFFFBBFRRR")).to include 567
      expect(runner.execute!("FFFBBBFRRR")).to include 119
      expect(runner.execute!("BBFFBBFRLL")).to include 820
    end
  end
end
