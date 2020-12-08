require "spec_helper"

RSpec.describe "Day 9: Explosives in Cyberspace" do
  let(:runner) { Runner.new("2016/09") }

  describe "Part One" do
    it "computes decompressed string lengths" do
      expect(runner.execute!("ADVENT", part: 1)).to eq(6)
      expect(runner.execute!("A(1x5)BC", part: 1)).to eq(7)
      expect(runner.execute!("(3x3)XYZ", part: 1)).to eq(9)
      expect(runner.execute!("A(2x2)BCD(2x2)EFG", part: 1)).to eq(11)
      expect(runner.execute!("(6x1)(1x3)A", part: 1)).to eq(6)
      expect(runner.execute!("X(8x2)(3x3)ABCY", part: 1)).to eq(18)
    end
  end

  describe "Part Two" do
    it "computes recursively decompressed string lengths" do
      expect(runner.execute!("ADVENT", part: 2)).to eq(6)
      expect(runner.execute!("(3x3)XYZ", part: 2)).to eq(9)
      expect(runner.execute!("X(8x2)(3x3)ABCY", part: 2)).to eq(20)
      expect(runner.execute!("(27x12)(20x12)(13x14)(7x10)(1x12)A", part: 2)).to eq(241_920)
      expect(runner.execute!("(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN", part: 2)).to eq(445)
    end
  end
end
