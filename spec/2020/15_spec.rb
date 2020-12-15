require "spec_helper"

RSpec.describe "Day 15: Rambunctious Recitation" do
  let(:runner) { Runner.new("2020/15") }
  let(:input) { "0,3,6" }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the 2020th number spoken" do
      expect(solution).to eq(436)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the 30000000th number spoken" do
      expect(solution).to eq(175_594)
    end
  end
end
