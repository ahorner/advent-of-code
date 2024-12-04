require "spec_helper"

RSpec.describe "Day 4: Ceres Search" do
  let(:runner) { Runner.new("2024/04") }
  let(:input) do
    <<~TXT
      MMMSXXMASM
      MSAMXMSMSA
      AMXSXMAAMM
      MSAMASMSMX
      XMASAMXAMM
      XXAMMXXAMA
      SMSMSASXSS
      SAXAMASAAA
      MAMMMXMMMM
      MXMXAXMASX
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "counts the number of XMASes in the grid" do
      expect(solution).to eq(18)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "counts the number of X-MASes in the grid" do
      expect(solution).to eq(9)
    end
  end
end
