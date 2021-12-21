require "spec_helper"

RSpec.describe "Day 21: Dirac Dice" do
  let(:runner) { Runner.new("2021/21") }
  let(:input) do
    <<~TXT
      Player 1 starting position: 4
      Player 2 starting position: 8
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "computes the final game state after a winner is decided" do
      expect(solution).to eq(739_785)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "computes the larger number of wins with quantum dice" do
      expect(solution).to eq(444_356_092_776_315)
    end
  end
end
