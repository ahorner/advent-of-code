require "spec_helper"

RSpec.describe "Day 22: Monkey Map" do
  let(:runner) { Runner.new("2022/22") }
  let(:input) do
    <<~TXT
              ...#
              .#..
              #...
              ....
      ...#.......#
      ........#...
      ..#....#....
      ..........#.
              ...#....
              .....#..
              .#......
              ......#.

      10R5L5R10L4R5L5
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the final password" do
      expect(solution).to eq(6032)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2, CUBE_SIZE: 4) }

    it "finds the final password for a cubic map" do
      expect(solution).to eq(5031)
    end
  end
end
