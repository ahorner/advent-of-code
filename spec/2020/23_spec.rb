require "spec_helper"

RSpec.describe "Day 23: Crab Cups" do
  let(:runner) { Runner.new("2020/23") }
  let(:input) { "389125467" }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the final cup order after 100 moves" do
      expect(solution).to eq("67384529")
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "multiplies the two labels clockwise from 1 after ten million moves" do
      expect(solution).to eq(149_245_887_792)
    end
  end
end
