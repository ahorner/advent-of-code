require "spec_helper"

RSpec.describe "Day 13: Packet Scanners" do
  let(:runner) { Runner.new("2017/13") }
  let(:input) do
    <<~TXT
      0: 3
      1: 2
      4: 4
      6: 4
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates trip severity across all layers" do
      expect(solution).to eq(24)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the minimum delay for safe crossing" do
      expect(solution).to eq(10)
    end
  end
end
