require "spec_helper"

RSpec.describe "Day 9: All in a Single Night" do
  let(:runner) { Runner.new("2015/09") }
  let(:input) do
    <<~TXT
      London to Dublin = 464
      London to Belfast = 518
      Dublin to Belfast = 141
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the shortest route between all locations" do
      expect(solution).to eq(605)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the longest route between all locations" do
      expect(solution).to eq(982)
    end
  end
end
