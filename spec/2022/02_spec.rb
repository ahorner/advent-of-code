require "spec_helper"

RSpec.describe "Day 2: Rock Paper Scissors" do
  let(:runner) { Runner.new("2022/02") }
  let(:input) do
    <<~TXT
      A Y
      B X
      C Z
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates total score of player when following move-based strategy guide" do
      expect(solution).to eq(15)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates total score of player when following outcome-based strategy guide" do
      expect(solution).to eq(12)
    end
  end
end

