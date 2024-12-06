require "spec_helper"

RSpec.describe "Day 6: Guard Gallivant" do
  let(:runner) { Runner.new("2024/06") }
  let(:input) do
    <<~TXT
      ....#.....
      .........#
      ..........
      ..#.......
      .......#..
      ..........
      .#..^.....
      ........#.
      #.........
      ......#...
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "counts the number of visited positions" do
      expect(solution).to eq(41)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "counts the number of new obstructions that can cause a loop" do
      expect(solution).to eq(6)
    end
  end
end
