require "spec_helper"

RSpec.describe "Day 24: Never Tell Me The Odds" do
  let(:runner) { Runner.new("2023/24") }
  let(:input) do
    <<~TXT
      19, 13, 30 @ -2,  1, -2
      18, 19, 22 @ -1, -1, -2
      20, 25, 34 @ -2, -2, -4
      12, 31, 28 @ -1, -2, -1
      20, 19, 15 @  1, -5, -3
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, RANGE: 7..27) }

    it "finds the number of hailstones that enter the test area" do
      expect(solution).to eq(2)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the position of the rock needed to hit all hailstones" do
      expect(solution).to eq(47)
    end
  end
end
