require "spec_helper"

describe "Day 2: I Was Told There Would Be No Math" do
  let(:runner) { Runner.new("2015/02") }

  describe "Part One" do
    it "computes total wrapping paper needed" do
      expect(runner.execute!("2x3x4\n1x1x10", part: 1)).to eq(101)
      expect(runner.execute!("2x3x4", part: 1)).to eq(58)
      expect(runner.execute!("1x1x10", part: 1)).to eq(43)
    end
  end

  describe "Part Two" do
    it "computes total ribbon needed" do
      expect(runner.execute!("2x3x4\n1x1x10", part: 2)).to eq(48)
      expect(runner.execute!("2x3x4", part: 2)).to eq(34)
      expect(runner.execute!("1x1x10", part: 2)).to eq(14)
    end
  end
end
