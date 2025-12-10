require "spec_helper"

RSpec.describe "Day 9: Movie Theater" do
  let(:runner) { Runner.new("2025/09") }
  let(:input) do
    <<~TXT
      7,1
      11,1
      11,7
      9,7
      9,5
      2,5
      2,3
      7,3
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the largest possible area given two corners" do
      expect(solution).to eq(50)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the largest fully-bound area given two corners" do
      expect(solution).to eq(24)
    end
  end
end
