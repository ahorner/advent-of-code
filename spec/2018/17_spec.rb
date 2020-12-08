require "spec_helper"

describe "Day 17: Reservoir Research" do
  let(:runner) { Runner.new("2018/17") }
  let(:input) do
    <<~TXT
      x=495, y=2..7
      y=7, x=495..501
      x=501, y=3..7
      x=498, y=2..4
      x=506, y=1..2
      x=498, y=10..13
      x=504, y=10..13
      y=13, x=498..504
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the number of tiles reachable by water" do
      expect(solution).to eq(57)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "determines the amount of water that will be retained" do
      expect(solution).to eq(29)
    end
  end
end
