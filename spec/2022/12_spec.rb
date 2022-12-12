require "spec_helper"

RSpec.describe "Day 12: Hill Climbing Algorithm" do
  let(:runner) { Runner.new("2022/12") }
  let(:input) do
    <<~TXT
      Sabqponm
      abcryxxl
      accszExk
      acctuvwj
      abdefghi
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the minimum steps to reach the goal" do
      expect(solution).to eq(31)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the minimum steps from an optimal trailhead" do
      expect(solution).to eq(29)
    end
  end
end
