require "spec_helper"

RSpec.describe "Day 14: Disk Defragmentation" do
  let(:runner) { Runner.new("2017/14") }
  let(:input) { "flqrgnkx" }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "computes the number of used spaces across a 128x128 grid" do
      expect(solution).to eq(8108)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "computes the total number of regions" do
      expect(solution).to eq(1242)
    end
  end
end
