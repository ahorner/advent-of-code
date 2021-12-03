require "spec_helper"

RSpec.describe "Day 3: Binary Diagnostic" do
  let(:runner) { Runner.new("2021/03") }
  let(:input) do
    <<~TXT
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the power consumption" do
      expect(solution).to eq(198)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the life support rating" do
      expect(solution).to eq(230)
    end
  end
end
