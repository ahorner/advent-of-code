require "spec_helper"

describe "Day 3: Spiral Memory" do
  let(:runner) { Runner.new("2017/03") }

  describe "Part One" do
    it "computes the manhattan distance to the access port" do
      expect(runner.execute!("1", part: 1)).to eq(0)
      expect(runner.execute!("12", part: 1)).to eq(3)
      expect(runner.execute!("23", part: 1)).to eq(2)
      expect(runner.execute!("1024", part: 1)).to eq(31)
    end
  end
end
