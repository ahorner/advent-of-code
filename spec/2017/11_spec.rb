require "spec_helper"

RSpec.describe "Day 11: Hex Ed" do
  let(:runner) { Runner.new("2017/11") }

  describe "Part One" do
    it "calculates final distances after following a path" do
      expect(runner.execute!("ne,ne,ne", part: 1)).to eq(3)
      expect(runner.execute!("ne,ne,sw,sw", part: 1)).to eq(0)
      expect(runner.execute!("ne,ne,s,s", part: 1)).to eq(2)
      expect(runner.execute!("se,sw,se,sw,sw", part: 1)).to eq(3)
    end
  end

  describe "Part Two" do
    it "calculates furthest distance on the path at any point" do
      expect(runner.execute!("ne,ne,ne", part: 2)).to eq(3)
      expect(runner.execute!("ne,ne,sw,sw", part: 2)).to eq(2)
      expect(runner.execute!("ne,ne,s,s", part: 2)).to eq(2)
      expect(runner.execute!("se,sw,se,sw,sw", part: 2)).to eq(3)
    end
  end
end
