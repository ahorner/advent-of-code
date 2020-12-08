require "spec_helper"

describe "Day 20: Infinite Elves and Infinite Houses" do
  let(:runner) { Runner.new("2015/20") }

  describe "Part One" do
    it "determines the first house to receive at least the specified number" do
      expect(runner.execute!("9", part: 1)).to eq(1)
      expect(runner.execute!("11", part: 1)).to eq(2)
      expect(runner.execute!("30", part: 1)).to eq(2)
      expect(runner.execute!("32", part: 1)).to eq(3)
      expect(runner.execute!("110", part: 1)).to eq(6)
      expect(runner.execute!("140", part: 1)).to eq(8)
    end
  end
end
