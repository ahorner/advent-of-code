require "spec_helper"

describe "Day 2: Inventory Management System" do
  let(:runner) { Runner.new("2018/02") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }
    let(:input) do
      <<~TXT
        abcdef
        bababc
        abbcde
        abcccd
        aabcdd
        abcdee
        ababab
      TXT
    end

    it "calculates a checksum" do
      expect(solution).to eq 12
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }
    let(:input) do
      <<~TXT
        abcde
        fghij
        klmno
        pqrst
        fguij
        axcye
        wvxyz
      TXT
    end

    it "finds the common letters for the Box IDs" do
      expect(solution).to eq "fgij"
    end
  end
end
