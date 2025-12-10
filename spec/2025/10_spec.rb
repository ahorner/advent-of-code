require "spec_helper"

RSpec.describe "Day 10: Factory" do
  let(:runner) { Runner.new("2025/10") }
  let(:input) do
    <<~TXT
      [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
      [...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
      [.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "sums the minimal presses to achieve the target light sequences" do
      expect(solution).to eq(7)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "sums the minimal presses to reach the target joltages" do
      expect(solution).to eq(33)
    end
  end
end
