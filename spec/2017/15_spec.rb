require "spec_helper"

RSpec.describe "Day 15: Dueling Generators" do
  let(:runner) { Runner.new("2017/15") }
  let(:input) do
    <<~TXT
      Generator A starts with 65
      Generator B starts with 8921
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, CHECKS: 5) }

    it "tallies the judge's count over iterations" do
      expect(solution).to eq(1)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "tallies the judge's counts with selective generation" do
      expect(solution).to eq(309)
    end
  end
end
