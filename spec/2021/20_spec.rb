require "spec_helper"

RSpec.describe "Day 20: Trench Map" do
  let(:runner) { Runner.new("2021/20") }
  let(:input) do
    <<~TXT
      ..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..###..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#..#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#......#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.....####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.......##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#

      #..#.
      #....
      ##..#
      ..#..
      ..###
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "counts the number of lit pixels after two refinements" do
      expect(solution).to eq(35)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "counts the number of lit pixels after 50 refinements" do
      expect(solution).to eq(3_351)
    end
  end
end
