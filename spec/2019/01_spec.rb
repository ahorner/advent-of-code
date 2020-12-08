require "spec_helper"

describe "Day 1: The Tyranny of the Rocket Equation" do
  let(:runner) { Runner.new("2019/01") }
  let(:input) do
    <<~TXT
      12
      14
      1969
      100756
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "sums the fuel requirements for all modules" do
      expect(solution).to eq(2 + 2 + 654 + 33_583)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "sums the fuel requirements, including fuel mass" do
      expect(solution).to eq(2 + 2 + 966 + 50_346)
    end
  end
end
