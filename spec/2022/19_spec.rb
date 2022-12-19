require "spec_helper"

RSpec.describe "Day 19: Not Enough Minerals" do
  let(:runner) { Runner.new("2022/19") }
  let(:input) do
    <<~TXT
      Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
      Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "sums the quality levels of blueprints" do
      expect(solution).to eq(33)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "multiplies the geode counts of the blueprints" do
      expect(solution).to eq(56 * 62)
    end
  end
end
