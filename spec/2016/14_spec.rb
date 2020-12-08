require "spec_helper"

describe "Day 14: One-Time Pad" do
  let(:runner) { Runner.new("2016/14") }
  let(:input) { "abc" }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the index that yields the 64th key" do
      expect(solution).to eq(22_728)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the index with key stretching" do
      expect(solution).to eq(22_551)
    end
  end
end
