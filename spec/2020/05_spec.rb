require "spec_helper"

describe "Day 5: Binary Boarding" do
  let(:runner) { Runner.new("2020/05") }

  describe "Part One" do
    it "calculates proper Seat IDs" do
      expect(runner.execute!("FBFBBFFRLR", part_one: true)[0]).to eq 357
      expect(runner.execute!("BFFFBBFRRR", part_one: true)[0]).to eq 567
      expect(runner.execute!("FFFBBBFRRR", part_one: true)[0]).to eq 119
      expect(runner.execute!("BBFFBBFRLL", part_one: true)[0]).to eq 820
    end
  end
end
