require "spec_helper"

RSpec.describe "Day 19: A Series of Tubes" do
  let(:runner) { Runner.new("2017/19") }
  let(:input) do
    <<~TXT
          |
          |  +--+
          A  |  C
      F---|----E|--+
          |  |  |  D
          +B-+  +--+
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "determines the order in which letters are found" do
      expect(solution).to eq("ABCDEF")
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "counts the total number of steps traveled" do
      expect(solution).to eq(38)
    end
  end
end
