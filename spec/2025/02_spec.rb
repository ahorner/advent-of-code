require "spec_helper"

RSpec.describe "Day 2: Gift Shop" do
  let(:runner) { Runner.new("2025/02") }
  let(:input) do
    <<~TXT
      11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
      1698522-1698528,446443-446449,38593856-38593862,565653-565659,
      824824821-824824827,2121212118-2121212124
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "sums the invalid IDs" do
      expect(solution).to eq(1227775554)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "sums the looser invalid IDs" do
      expect(solution).to eq(4174379265)
    end
  end
end
