require "spec_helper"

describe "Day 19: An Elephant Named Joseph" do
  let(:runner) { Runner.new("2016/19") }
  let(:input) { "5" }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "determines who wins" do
      expect(solution).to eq(3)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "determines who wins with updated rules" do
      expect(solution).to eq(2)
    end
  end
end
