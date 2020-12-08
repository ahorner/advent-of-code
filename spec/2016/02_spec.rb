require "spec_helper"

describe "Day 2: Bathroom Security" do
  let(:runner) { Runner.new("2016/02") }
  let(:input) do
    <<~TXT
      ULL
      RRDDD
      LURDL
      UUUUD
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "enters a code from the instructions" do
      expect(solution).to eq("1985")
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "enters a code on a wonky keypad" do
      expect(solution).to eq("5DB3")
    end
  end
end
