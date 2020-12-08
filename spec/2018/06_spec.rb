require "spec_helper"

describe "Day 6: Chronal Coordinates" do
  let(:runner) { Runner.new("2018/06") }
  let(:input) do
    <<~TXT
      1, 1
      1, 6
      8, 3
      3, 4
      5, 5
      8, 9
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the largest non-infinite area" do
      expect(solution).to eq(17)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2, MAX_DISTANCE: 32) }

    it "finds the area of a central region" do
      expect(solution).to eq(16)
    end
  end
end
