require "spec_helper"

RSpec.describe "Day 1: Historian Hysteria" do
  let(:runner) { Runner.new("2024/01") }
  let(:input) do
    <<~TXT
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the total distances between ordered numbers" do
      expect(solution).to eq(11)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the total sum of similarity scoes" do
      expect(solution).to eq(31)
    end
  end
end
