require "spec_helper"

RSpec.describe "Day 10: Elves Look, Elves Say" do
  let(:runner) { Runner.new("2015/10") }

  describe "Part One" do
    it "computes the result length after sequencing" do
      expect(runner.execute!("1", part: 1, TIMES: 1)).to eq(2) # 11
      expect(runner.execute!("1", part: 1, TIMES: 2)).to eq(2) # 21
      expect(runner.execute!("1", part: 1, TIMES: 3)).to eq(4) # 1211
      expect(runner.execute!("1", part: 1, TIMES: 4)).to eq(6) # 111221
      expect(runner.execute!("1", part: 1, TIMES: 5)).to eq(6) # 312211

      expect(runner.execute!("111221", part: 1, TIMES: 1)).to eq(6) # 312211
    end
  end
end
