require "spec_helper"

RSpec.describe "Day 14: Regolith Reservoir" do
  let(:runner) { Runner.new("2022/14") }
  let(:input) do
    <<~TXT
      498,4 -> 498,6 -> 496,6
      503,4 -> 502,4 -> 502,9 -> 494,9
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "computes resting sand units with a bottomless void" do
      expect(solution).to eq(24)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "computes resting sand units with a floor" do
      expect(solution).to eq(93)
    end
  end
end
