require "spec_helper"

describe "Day 16: Flawed Frequency Transmission" do
  let(:runner) { Runner.new("2019/16") }

  describe "Part One" do
    it "computes the first eight digits of the FFT output list" do
      expect(runner.execute!("12345678", part: 1, PHASES: 4)).to eq("01029498")
      expect(runner.execute!("80871224585914546619083218645595", part: 1)).to eq("24176176")
      expect(runner.execute!("19617804207202209144916044189917", part: 1)).to eq("73745418")
      expect(runner.execute!("69317163492948606335995924319873", part: 1)).to eq("52432133")
    end
  end

  describe "Part Two" do
    it "computes a final eight-digit message" do
      expect(runner.execute!("03036732577212944063491565474664", part: 2)).to eq("84462026")
      expect(runner.execute!("02935109699940807407585447034323", part: 2)).to eq("78725270")
      expect(runner.execute!("03081770884921959731165446850517", part: 2)).to eq("53553731")
    end
  end
end
