require "spec_helper"

RSpec.describe "Day 8: Treetop Tree House" do
  let(:runner) { Runner.new("2022/08") }
  let(:input) do
    <<~TXT
      30373
      25512
      65332
      33549
      35390
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the number of visible trees" do
      expect(solution).to eq(21)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the highest scenic score" do
      expect(solution).to eq(8)
    end
  end
end
