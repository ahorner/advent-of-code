require "spec_helper"

RSpec.describe "Day 7: Bridge Repair" do
  let(:runner) { Runner.new("2024/07") }
  let(:input) do
    <<~TXT
      190: 10 19
      3267: 81 40 27
      83: 17 5
      156: 15 6
      7290: 6 8 6 15
      161011: 16 10 13
      192: 17 8 14
      21037: 9 7 18 13
      292: 11 6 16 20
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "sums the calibration results" do
      expect(solution).to eq(3749)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "sums the calibration results including concatenation" do
      expect(solution).to eq(11387)
    end
  end
end
