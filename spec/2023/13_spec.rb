require "spec_helper"

RSpec.describe "Day 13: Point of Incidence" do
  let(:runner) { Runner.new("2023/13") }
  let(:input) do
    <<~TXT
      #.##..##.
      ..#.##.#.
      ##......#
      ##......#
      ..#.##.#.
      ..##..##.
      #.#.##.#.

      #...##..#
      #....#..#
      ..##..###
      #####.##.
      #####.##.
      ..##..###
      #....#..#
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the vertical and horizontal mirror lines" do
      expect(solution).to eq(405)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the mirror lines after fixing smudges" do
      expect(solution).to eq(400)
    end
  end
end
