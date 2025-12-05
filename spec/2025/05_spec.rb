require "spec_helper"

RSpec.describe "Day 5: Cafeteria" do
  let(:runner) { Runner.new("2025/05") }
  let(:input) do
    <<~TXT
      3-5
      10-14
      16-20
      12-18

      1
      5
      8
      11
      17
      32
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the count of fresh ingredients by ID" do
      expect(solution).to eq(3)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "determines the total number of fresh ingredients" do
      expect(solution).to eq(14)
    end
  end
end
