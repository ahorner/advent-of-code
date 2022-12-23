require "spec_helper"

RSpec.describe "Day 23: Unstable Diffusion" do
  let(:runner) { Runner.new("2022/23") }
  let(:input) do
    <<~TXT
      ....#..
      ..###.#
      #...#.#
      .#...##
      #.###..
      ##.#.##
      .#..#..
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the number of ground tiles" do
      expect(solution).to eq(110)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the first round that no elves move" do
      expect(solution).to eq(20)
    end
  end
end
