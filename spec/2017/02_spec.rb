require "spec_helper"

describe "Day 2: Corruption Checksum" do
  let(:runner) { Runner.new("2017/02") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }
    let(:input) do
      <<~TXT
        5 1 9 5
        7 5 3
        2 4 6 8
      TXT
    end

    it "computes a difference checksum for a spreadsheet" do
      expect(solution).to eq(18)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }
    let(:input) do
      <<~TXT
        5 9 2 8
        9 4 7 3
        3 8 6 5
      TXT
    end

    it "computes a division checksum for a spreadsheet" do
      expect(solution).to eq(9)
    end
  end
end
