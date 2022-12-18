require "spec_helper"

RSpec.describe "Day 18: Boiling Boulders" do
  let(:runner) { Runner.new("2022/18") }
  let(:input) do
    <<~TXT
      2,2,2
      1,2,2
      3,2,2
      2,1,2
      2,3,2
      2,2,1
      2,2,3
      2,2,4
      2,2,6
      1,2,5
      3,2,5
      2,1,5
      2,3,5
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the number of exposed sides" do
      expect(solution).to eq(64)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds only the exterior surface area" do
      expect(solution).to eq(58)
    end
  end
end
