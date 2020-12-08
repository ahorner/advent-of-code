require "spec_helper"

describe "Day 1: Inverse Captcha" do
  let(:runner) { Runner.new("2017/01") }

  describe "Part One" do
    it "solves a continuous captcha" do
      expect(runner.execute!("1122", part: 1)).to eq(3)
      expect(runner.execute!("1111", part: 1)).to eq(4)
      expect(runner.execute!("1234", part: 1)).to eq(0)
      expect(runner.execute!("91212129", part: 1)).to eq(9)
    end
  end

  describe "Part Two" do
    it "solves an offset captcha" do
      expect(runner.execute!("1212", part: 2)).to eq(6)
      expect(runner.execute!("1221", part: 2)).to eq(0)
      expect(runner.execute!("123425", part: 2)).to eq(4)
      expect(runner.execute!("123123", part: 2)).to eq(12)
      expect(runner.execute!("12131415", part: 2)).to eq(4)
    end
  end
end
