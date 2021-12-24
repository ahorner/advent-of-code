require "spec_helper"

RSpec.describe "Day 23: Amphipod" do
  let(:runner) { Runner.new("2021/23") }
  let(:input) do
    <<~TXT
      #############
      #...........#
      ###B#C#B#D###
        #A#D#C#A#
        #########
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "computes the minimum cost to sort all amphipods" do
      expect(solution).to eq(12_521)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "computes the minimum cost to sort a full set of amphipods" do
      expect(solution).to eq(44_169)
    end
  end
end
