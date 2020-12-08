require "spec_helper"

describe "Day 17: No Such Thing as Too Much" do
  let(:runner) { Runner.new("2015/17") }
  let(:input) do
    <<~TXT
      20
      15
      10
      5
      5
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, LITERS: 25) }

    it "finds the total combinations that add to the target" do
      expect(solution).to eq(4)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2, LITERS: 25) }

    it "finds the number of ways to use a minimal container count" do
      expect(solution).to eq(3)
    end
  end
end
