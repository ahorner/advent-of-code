require "spec_helper"

describe "Day 8: Two-Factor Authentication" do
  let(:runner) { Runner.new("2016/08") }
  let(:input) do
    <<~TXT
      rect 3x2
      rotate column x=1 by 1
      rotate row y=0 by 4
      rotate column x=1 by 1
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, SCREEN_DIMENSIONS: [7, 3]) }

    it "calculates the number of lit pixels" do
      expect(solution).to eq(6)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2, SCREEN_DIMENSIONS: [7, 3]) }

    it "renders the final result on the screen" do
      expect(solution).to eq <<~TXT.strip
        .#..#.#
        #.#....
        .#.....
      TXT
    end
  end
end
