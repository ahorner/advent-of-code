require "spec_helper"

RSpec.describe "Day 8: Resonant Collinearity" do
  let(:runner) { Runner.new("2024/08") }
  let(:input) do
    <<~TXT
      ............
      ........0...
      .....0......
      .......0....
      ....0.......
      ......A.....
      ............
      ............
      ........A...
      .........A..
      ............
      ............
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "counts the number of unique antinode locations" do
      expect(solution).to eq(14)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "counts the number of antinodes with an updated model" do
      expect(solution).to eq(34)
    end
  end
end
