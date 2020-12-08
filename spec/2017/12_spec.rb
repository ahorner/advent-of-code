require "spec_helper"

RSpec.describe "Day 12: Digital Plumber" do
  let(:runner) { Runner.new("2017/12") }
  let(:input) do
    <<~TXT
      0 <-> 2
      1 <-> 1
      2 <-> 0, 3, 4
      3 <-> 2, 4
      4 <-> 2, 3, 6
      5 <-> 6
      6 <-> 4, 5
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the number of programs grouped with 0" do
      expect(solution).to eq(6)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the total number of groups" do
      expect(solution).to eq(2)
    end
  end
end
