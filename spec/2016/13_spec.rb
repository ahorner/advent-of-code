require "spec_helper"

describe "Day 13: A Maze of Twisty Little Cubicles" do
  let(:runner) { Runner.new("2016/13") }
  let(:input) { "10" }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, TARGET: [7, 4]) }

    it "computes the minimum number of steps to the target" do
      expect(solution).to eq(11)
    end
  end
end
