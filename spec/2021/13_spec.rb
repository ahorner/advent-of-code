require "spec_helper"

RSpec.describe "Day 13: Transparent Origami" do
  let(:runner) { Runner.new("2021/13") }
  let(:input) do
    <<~TXT
      6,10
      0,14
      9,10
      0,3
      10,4
      4,11
      6,0
      6,12
      4,1
      0,13
      10,12
      3,4
      3,0
      8,4
      1,10
      2,14
      8,10
      9,0

      fold along y=7
      fold along x=5
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "computes the number of visible dots after folding" do
      expect(solution).to eq(17)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "renders the content of the folded paper" do
      expect(solution).to eq(<<~TXT)
        #####
        #...#
        #...#
        #...#
        #####
      TXT
    end
  end
end
