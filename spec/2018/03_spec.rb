require "spec_helper"

describe "Day 3: No Matter How You Slice It" do
  let(:runner) { Runner.new("2018/03") }
  let(:input) do
    <<~TXT
      #1 @ 1,3: 4x4
      #2 @ 3,1: 4x4
      #3 @ 5,5: 2x2
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the overlapping area" do
      expect(solution).to eq 4
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the non-overlapping claim" do
      expect(solution).to eq "3"
    end
  end
end
