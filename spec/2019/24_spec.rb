require "spec_helper"

describe "Day 24: Planet of Discord" do
  let(:runner) { Runner.new("2019/24") }
  let(:input) do
    <<~TXT
      ....#
      #..#.
      #..##
      ..#..
      #....
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates a biodiversity rating after a full cycle" do
      expect(solution).to eq(2_129_920)
    end
  end

  describe "Part Two" do
    it "counts the number of bugs in a recursive ecosystem" do
      solution = runner.execute!(input, part: 2, MINUTES: 10)
      expect(solution).to eq(99)
    end
  end
end
