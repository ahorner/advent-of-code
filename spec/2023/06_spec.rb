require "spec_helper"

RSpec.describe "Day 6: Wait For It" do
  let(:runner) { Runner.new("2023/06") }
  let(:input) do
    <<~TXT
      Time:      7  15   30
      Distance:  9  40  200
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the number of winning strategies" do
      expect(solution).to eq(288)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the number of single-race strategies" do
      expect(solution).to eq(71503)
    end
  end
end
