require "spec_helper"

describe "Day 1: Report Repair" do
  let(:runner) { Runner.new("2020/01") }
  let(:input) do
    <<~TXT
      1721
      979
      366
      299
      675
      1456
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input).first }

    it "correctly identifies two entries that sum to 2020" do
      expect(solution).to eq 514_579
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input).last }

    it "correctly identifies three entries that sum to 2020" do
      expect(solution).to eq 241_861_950
    end
  end
end
