require "spec_helper"

describe "Day 2: 1202 Program Alarm" do
  let(:runner) { Runner.new("2019/02") }

  describe "Part One" do
    it "checks the final value of position 0" do
      expect(runner.execute!("1,9,10,3,2,3,11,0,99,30,40,50", part: 1, SETTING: [9, 10])).to eq(3_500)
      expect(runner.execute!("1,0,0,0,99", part: 1, SETTING: [0, 0])).to eq(2)
      expect(runner.execute!("2,3,0,3,99", part: 1, SETTING: [3, 0])).to eq(2)
      expect(runner.execute!("2,4,4,5,99,0", part: 1, SETTING: [4, 4])).to eq(2)
      expect(runner.execute!("1,1,1,4,99,5,6,0,99", part: 1, SETTING: [1, 1])).to eq(30)
    end
  end
end
