require "spec_helper"

describe "Day 5: A Maze of Twisty Trampolines, All Alike" do
  let(:runner) { Runner.new("2017/05") }
  let(:input) do
    <<~TXT
      0
      3
      0
      1
      -3
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "counts the steps to the exit" do
      expect(solution).to eq(5)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "counts the steps the the exit with strange jumps" do
      expect(solution).to eq(10)
    end
  end
end
