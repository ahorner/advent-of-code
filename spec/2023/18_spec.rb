require "spec_helper"

RSpec.describe "Day 18: Lavaduct Lagoon" do
  let(:runner) { Runner.new("2023/18") }
  let(:input) do
    <<~TXT
      R 6 (#70c710)
      D 5 (#0dc571)
      L 2 (#5713f0)
      D 2 (#d2c081)
      R 2 (#59c680)
      D 2 (#411b91)
      L 5 (#8ceee2)
      U 2 (#caa173)
      L 1 (#1b58a2)
      U 2 (#caa171)
      R 2 (#7807d2)
      U 3 (#a77fa3)
      L 2 (#015232)
      U 2 (#7a21e3)
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the lava holding capacity" do
      expect(solution).to eq(62)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the capacity for a lagoon using the coded plan" do
      expect(solution).to eq(952408144115)
    end
  end
end
