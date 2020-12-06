require "spec_helper"

describe "Day 3: Toboggan Trajectory" do
  let(:runner) { Runner.new("2020/03") }
  let(:input) do
    <<~TXT
      ..##.......
      #...#...#..
      .#....#..#.
      ..#.#...#.#
      .#...##..#.
      ..#.##.....
      .#.#.#....#
      .#........#
      #.##...#...
      #...##....#
      .#..#...#.#
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input).first }

    it "properly counts tree collisions" do
      expect(solution).to eq 7
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input).last }

    it "properly multiplies tree collisions across slopes" do
      expect(solution).to eq 336
    end
  end
end
