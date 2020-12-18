require "spec_helper"

RSpec.describe "Day 18: Operation Order" do
  let(:runner) { Runner.new("2020/18") }

  describe "Part One" do
    it "computes values with no operation precedence" do
      expect(runner.execute!("1 + (2 * 3) + (4 * (5 + 6))", part: 1)).to eq(51)
      expect(runner.execute!("2 * 3 + (4 * 5)", part: 1)).to eq(26)
      expect(runner.execute!("5 + (8 * 3 + 9 + 3 * 4 * 3)", part: 1)).to eq(437)
      expect(runner.execute!("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))", part: 1)).to eq(12_240)
      expect(runner.execute!("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2", part: 1)).to eq(13_632)
    end
  end

  describe "Part Two" do
    it "computes values with reversed operation precedence" do
      expect(runner.execute!("1 + (2 * 3) + (4 * (5 + 6))", part: 2)).to eq(51)
      expect(runner.execute!("2 * 3 + (4 * 5)", part: 2)).to eq(46)
      expect(runner.execute!("5 + (8 * 3 + 9 + 3 * 4 * 3)", part: 2)).to eq(1_445)
      expect(runner.execute!("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))", part: 2)).to eq(669_060)
      expect(runner.execute!("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2", part: 2)).to eq(23_340)
    end
  end
end
