require "spec_helper"

describe "Day 8: Matchsticks" do
  let(:runner) { Runner.new("2015/08") }

  describe "Part One" do
    it "determines the difference in in-memory and string length" do
      expect(runner.execute!('""', part: 1)).to eq(2)
      expect(runner.execute!('"abc"', part: 1)).to eq(2)
      expect(runner.execute!('"aaa\"aaa"', part: 1)).to eq(3)
      expect(runner.execute!('"\x27"', part: 1)).to eq(5)
    end
  end

  describe "Part Two" do
    it "determines the difference in original and encoded length" do
      expect(runner.execute!('""', part: 2)).to eq(4)
      expect(runner.execute!('"abc"', part: 2)).to eq(4)
      expect(runner.execute!('"aaa\"aaa"', part: 2)).to eq(6)
      expect(runner.execute!('"\x27"', part: 2)).to eq(5)
    end
  end
end
