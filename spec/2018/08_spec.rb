require "spec_helper"

describe "Day 8: Memory Maneuver" do
  let(:runner) { Runner.new("2018/08") }
  let(:input) { "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2" }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "sums metadata entries" do
      expect(solution).to eq(138)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the value of the root node" do
      expect(solution).to eq(66)
    end
  end
end
