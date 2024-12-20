require "spec_helper"

RSpec.describe "Day 19: Linen Layout" do
  let(:runner) { Runner.new("2024/19") }
  let(:input) do
    <<~TXT
      r, wr, b, g, bwu, rb, gb, br

      brwrr
      bggr
      gbbr
      rrbgbr
      ubwu
      bwurrg
      brgr
      bbrgwb
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "counts the number of possible designs" do
      expect(solution).to eq(6)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "sums the unique methods to make valid designs" do
      expect(solution).to eq(16)
    end
  end
end
