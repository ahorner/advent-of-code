require "spec_helper"

RSpec.describe "Day 25: Code Chronicle" do
  let(:runner) { Runner.new("2024/25") }
  let(:input) do
    <<~TXT
      #####
      .####
      .####
      .####
      .#.#.
      .#...
      .....

      #####
      ##.##
      .#.##
      ...##
      ...#.
      ...#.
      .....

      .....
      #....
      #....
      #...#
      #.#.#
      #.###
      #####

      .....
      .....
      #.#..
      ###..
      ###.#
      ###.#
      #####

      .....
      .....
      .....
      #....
      #.#..
      #.#.#
      #####
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the number of unique lock/key pairs without overlap" do
      expect(solution).to eq(3)
    end
  end
end
