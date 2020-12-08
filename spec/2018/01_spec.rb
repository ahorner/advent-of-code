require "spec_helper"

RSpec.describe "Day 1: Chronal Calibration" do
  let(:runner) { Runner.new("2018/01") }

  describe "Part One" do
    it "calculates the resulting frequency" do
      expect(runner.execute!(%w[+1 -2 +3 +1].join("\n"), part: 1)).to eq(3)
      expect(runner.execute!(%w[+1 +1 +1].join("\n"), part: 1)).to eq(3)
      expect(runner.execute!(%w[+1 +1 -2].join("\n"), part: 1)).to eq(0)
      expect(runner.execute!(%w[-1 -2 -3].join("\n"), part: 1)).to eq(-6)
    end
  end

  describe "Part Two" do
    it "finds the first recurring frequency" do
      expect(runner.execute!(%w[+1 -2 +3 +1].join("\n"), part: 2)).to eq(2)
      expect(runner.execute!(%w[+1 -1].join("\n"), part: 2)).to eq(0)
      expect(runner.execute!(%w[+3 +3 +4 -2 -4].join("\n"), part: 2)).to eq(10)
      expect(runner.execute!(%w[-6 +3 +8 +5 -6].join("\n"), part: 2)).to eq(5)
      expect(runner.execute!(%w[+7 +7 -2 -7 -4].join("\n"), part: 2)).to eq(14)
    end
  end
end
