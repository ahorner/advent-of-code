require "spec_helper"

RSpec.describe "Day 1: Calorie Counting" do
  let(:runner) { Runner.new("2022/01") }
  let(:input) do
    <<~TXT
      1000
      2000
      3000

      4000

      5000
      6000

      7000
      8000
      9000

      10000
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the elf carrying the most calories" do
      expect(solution).to eq(24_000)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the top three calorie counts" do
      expect(solution).to eq(45_000)
    end
  end
end
