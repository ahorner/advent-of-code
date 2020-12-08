require "spec_helper"

describe "Day 14: Chocolate Charts" do
  let(:runner) { Runner.new("2018/14") }

  describe "Part One" do
    it "calculates the scores of the recipes after improvement" do
      expect(runner.execute!("9", part: 1)).to eq("5158916779")
      expect(runner.execute!("5", part: 1)).to eq("0124515891")
      expect(runner.execute!("18", part: 1)).to eq("9251071085")
      expect(runner.execute!("2018", part: 1)).to eq("5941429882")
    end
  end

  describe "Part Two" do
    it "finds the number of recipes needed to reach the target score" do
      expect(runner.execute!("51589", part: 2)).to eq(9)
      expect(runner.execute!("01245", part: 2)).to eq(5)
      expect(runner.execute!("92510", part: 2)).to eq(18)
      expect(runner.execute!("59414", part: 2)).to eq(2018)
    end
  end
end
