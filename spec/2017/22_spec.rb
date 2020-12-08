require "spec_helper"

describe "Day 22: Sporifica Virus" do
  let(:runner) { Runner.new("2017/22") }
  let(:input) do
    <<~TXT
      ..#
      #..
      ...
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the number of infections" do
      expect(solution).to eq 5_587
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the number of evolved infections" do
      expect(solution).to eq 2_511_944
    end
  end
end
