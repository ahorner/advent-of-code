require "spec_helper"

RSpec.describe "Day 9: Mirage Maintenance" do
  let(:runner) { Runner.new("2023/09") }
  let(:input) do
    <<~TXT
      0 3 6 9 12 15
      1 3 6 10 15 21
      10 13 16 21 30 45
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "sums the extrapolated next values" do
      expect(solution).to eq(114)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "sums the extrapolated previous values" do
      expect(solution).to eq(2)
    end
  end
end
