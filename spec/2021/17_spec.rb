require "spec_helper"

RSpec.describe "Day 17: Trick Shot" do
  let(:runner) { Runner.new("2021/17") }
  let(:input) do
    <<~TXT
      target area: x=20..30, y=-10..-5
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "computes the maximum height achieved while hitting the target area" do
      expect(solution).to eq(45)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "computes the number of working initial velocities" do
      expect(solution).to eq(112)
    end
  end
end
