require "spec_helper"

RSpec.describe "Day 11: Dumbo Octopus" do
  let(:runner) { Runner.new("2021/11") }
  let(:input) do
    <<~TXT
      5483143223
      2745854711
      5264556173
      6141336146
      6357385478
      4167524645
      2176841721
      6882881134
      4846848554
      5283751526
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "computes the number of flashes after 100 steps" do
      expect(solution).to eq(1_656)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the first step where the octopuses synchronize" do
      expect(solution).to eq(195)
    end
  end
end
