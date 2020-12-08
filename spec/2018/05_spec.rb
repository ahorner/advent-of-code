require "spec_helper"

describe "Day 5: Alchemical Reduction" do
  let(:runner) { Runner.new("2018/05") }
  let(:input) { "dabAcCaCBAcCcaDA" }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "counts the remaining polymer units after reaction" do
      expect(solution).to eq(10)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the problematic unit type" do
      expect(solution).to eq(4)
    end
  end
end
