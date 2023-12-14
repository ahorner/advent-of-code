require "spec_helper"

RSpec.describe "Day 14: Parabolic Reflector Dish" do
  let(:runner) { Runner.new("2023/14") }
  let(:input) do
    <<~TXT
      O....#....
      O.OO#....#
      .....##...
      OO.#O....O
      .O.....O#.
      O.#..O.#.#
      ..O..#O..O
      .......O..
      #....###..
      #OO..#....
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the total load after tilting north" do
      expect(solution).to eq(136)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the total load after many cycles" do
      expect(solution).to eq(64)
    end
  end
end
