require "spec_helper"

describe "Day 18: Like a Rogue" do
  let(:runner) { Runner.new("2016/18") }

  describe "Part One" do
    it "calculates the number of safe tiles" do
      expect(runner.execute!("..^^.", part: 1, ROW_COUNT: 3)).to eq(6)
      expect(runner.execute!(".^^.^.^^^^", part: 1, ROW_COUNT: 10)).to eq(38)
    end
  end
end
