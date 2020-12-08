require "spec_helper"

RSpec.describe "Day 3: Perfectly Spherical Houses in a Vacuum" do
  let(:runner) { Runner.new("2015/03") }

  describe "Part One" do
    it "counts total houses on delivery route" do
      expect(runner.execute!(">", part: 1)).to eq(2)
      expect(runner.execute!("^>v<", part: 1)).to eq(4)
      expect(runner.execute!("^v^v^v^v^v", part: 1)).to eq(2)
    end
  end

  describe "Part Two" do
    it "counts total houses on delivery route" do
      expect(runner.execute!("^v", part: 2)).to eq(3)
      expect(runner.execute!("^>v<", part: 2)).to eq(3)
      expect(runner.execute!("^v^v^v^v^v", part: 2)).to eq(11)
    end
  end
end
