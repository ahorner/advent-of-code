require "spec_helper"

RSpec.describe "Day 9: Smoke Basin" do
  let(:runner) { Runner.new("2021/09") }
  let(:input) do
    <<~TXT
      2199943210
      3987894921
      9856789892
      8767896789
      9899965678
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "sums the risk levels of low points" do
      expect(solution).to eq(15)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the product of the three largest basin sizes" do
      expect(solution).to eq(1_134)
    end
  end
end
