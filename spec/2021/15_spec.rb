require "spec_helper"

RSpec.describe "Day 15: Chiton" do
  let(:runner) { Runner.new("2021/15") }
  let(:input) do
    <<~TXT
      1163751742
      1381373672
      2136511328
      3694931569
      7463417111
      1319128137
      1359912421
      3125421639
      1293138521
      2311944581
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the lowest risk necessary to traverse the cave" do
      expect(solution).to eq(40)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the lowest risk necessary to traverse the deep cave" do
      expect(solution).to eq(315)
    end
  end
end
