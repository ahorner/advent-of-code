require "spec_helper"

describe "Day 4: Secure Container" do
  let(:runner) { Runner.new("2019/04") }

  describe "Part One" do
    it "finds passwords that meet the criteria" do
      expect(runner.execute!("111111-111111", part: 1)).to eq(1)
      expect(runner.execute!("123444-123444", part: 1)).to eq(1)
      expect(runner.execute!("223450-223450", part: 1)).to eq(0)
      expect(runner.execute!("123789-123789", part: 1)).to eq(0)
    end
  end

  describe "Part Two" do
    it "finds passwords that meet the stricter criteria" do
      expect(runner.execute!("112233-112233", part: 2)).to eq(1)
      expect(runner.execute!("123444-123444", part: 2)).to eq(0)
      expect(runner.execute!("111122-111122", part: 2)).to eq(1)
    end
  end
end
