require "spec_helper"

RSpec.describe "Day 17: Conway Cubes" do
  let(:runner) { Runner.new("2020/17") }
  let(:input) do
    <<~TXT
      .#.
      ..#
      ###
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "counts the 3-dimensional active cubes after boot" do
      expect(solution).to eq(112)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "counts the 4-dimensional active cubes after boot" do
      expect(solution).to eq(848)
    end
  end
end
