require "spec_helper"

RSpec.describe "Day 3: Lobby" do
  let(:runner) { Runner.new("2025/03") }
  let(:input) do
    <<~TXT
      987654321111111
      811111111111119
      234234234234278
      818181911112111
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the total output joltage" do
      expect(solution).to eq(357)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the total output joltage with more batteries" do
      expect(solution).to eq(3121910778619)
    end
  end
end
