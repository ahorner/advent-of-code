require "spec_helper"

RSpec.describe "Day 22: Crab Combat" do
  let(:runner) { Runner.new("2020/22") }
  let(:input) do
    <<~TXT
      Player 1:
      9
      2
      6
      3
      1

      Player 2:
      5
      8
      4
      7
      10
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the winning player's score" do
      expect(solution).to eq(306)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the winner's score after recursive combat" do
      expect(solution).to eq(291)
    end
  end
end
