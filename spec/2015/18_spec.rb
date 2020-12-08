require "spec_helper"

RSpec.describe "Day 18: Like a GIF For Your Yard" do
  let(:runner) { Runner.new("2015/18") }
  let(:input) do
    <<~TXT
      .#.#.#
      ...##.
      #....#
      ..#...
      #.#..#
      ####..
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, STEPS: 4) }

    it "counts the lights after N steps" do
      expect(solution).to eq(4)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2, STEPS: 5) }

    it "counts the lights with stuck corners" do
      expect(solution).to eq(17)
    end
  end
end
