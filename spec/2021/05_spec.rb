require "spec_helper"

RSpec.describe "Day 5: Hydrothermal Venture" do
  let(:runner) { Runner.new("2021/05") }
  let(:input) do
    <<~TXT
      0,9 -> 5,9
      8,0 -> 0,8
      9,4 -> 3,4
      2,2 -> 2,1
      7,0 -> 7,4
      6,4 -> 2,0
      0,9 -> 2,9
      3,4 -> 1,4
      0,0 -> 8,8
      5,5 -> 8,2
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the number of overlapping vents" do
      expect(solution).to eq(5)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the number of overlapping vents with diagonals" do
      expect(solution).to eq(12)
    end
  end
end
