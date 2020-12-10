require "spec_helper"

RSpec.describe "Day 10: Adapter Array" do
  let(:runner) { Runner.new("2020/10") }
  let(:short_input) do
    <<~TXT
      16
      10
      15
      5
      1
      11
      7
      19
      6
      12
      4
    TXT
  end
  let(:long_input) do
    <<~TXT
      28
      33
      18
      42
      31
      14
      46
      20
      48
      47
      24
      23
      49
      45
      19
      38
      39
      11
      1
      32
      25
      35
      8
      17
      7
      9
      4
      2
      34
      10
      3
    TXT
  end

  describe "Part One" do
    it "multiplies the counts of 1- and 3-jolt differences" do
      expect(runner.execute!(short_input, part: 1)).to eq(7 * 5)
      expect(runner.execute!(long_input, part: 1)).to eq(22 * 10)
    end
  end

  describe "Part Two" do
    it "computes the number of valid arrangements" do
      expect(runner.execute!(short_input, part: 2)).to eq(8)
      expect(runner.execute!(long_input, part: 2)).to eq(19_208)
    end
  end
end
