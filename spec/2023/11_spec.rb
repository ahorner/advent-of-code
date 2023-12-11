require "spec_helper"

RSpec.describe "Day 11: Cosmic Expansion" do
  let(:runner) { Runner.new("2023/11") }
  let(:input) do
    <<~TXT
      ...#......
      .......#..
      #.........
      ..........
      ......#...
      .#........
      .........#
      ..........
      .......#..
      #...#.....
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "sums the minimum distances between pairs of planets" do
      expect(solution).to eq(374)
    end
  end

  describe "Part Two" do
    it "sums the minimum distances with more expansion" do
      expect(runner.execute!(input, part: 2, EXPANSION_FACTOR: 10)).to eq(1030)
      expect(runner.execute!(input, part: 2, EXPANSION_FACTOR: 100)).to eq(8410)
    end
  end
end
