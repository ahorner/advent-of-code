require "spec_helper"

RSpec.describe "Day 1: No Time for a Taxicab" do
  let(:runner) { Runner.new("2016/01") }

  describe "Part One" do
    it "calculates the final distance" do
      expect(runner.execute!("R2, L3", part: 1)).to eq(5)
      expect(runner.execute!("R2, R2, R2", part: 1)).to eq(2)
      expect(runner.execute!("R5, L5, R5, R3", part: 1)).to eq(12)
    end
  end

  describe "Part Two" do
    it "finds the distance to the first spot visited twice" do
      expect(runner.execute!("R8, R4, R4, R8", part: 2)).to eq(4)
    end
  end
end
