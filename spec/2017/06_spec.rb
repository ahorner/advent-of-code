require "spec_helper"

RSpec.describe "Day 6: Memory Reallocation" do
  let(:runner) { Runner.new("2017/06") }
  let(:input) { "0 2 7 0" }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "counts the redistribution cycles before looping" do
      expect(solution).to eq(5)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "counts the cycles in the infinite loop" do
      expect(solution).to eq(4)
    end
  end
end
