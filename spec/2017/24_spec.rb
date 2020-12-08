require "spec_helper"

RSpec.describe "Day 24: Electromagnetic Moat" do
  let(:runner) { Runner.new("2017/24") }
  let(:input) do
    <<~TXT
      0/2
      2/2
      2/3
      3/4
      3/5
      0/1
      10/1
      9/10
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the strength of the strongest bridge" do
      expect(solution).to eq 31
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the length of the longest bridge" do
      expect(solution).to eq 19
    end
  end
end
