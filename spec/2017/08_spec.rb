require "spec_helper"

RSpec.describe "Day 8: I Heard You Like Registers" do
  let(:runner) { Runner.new("2017/08") }
  let(:input) do
    <<~TXT
      b inc 5 if a > 1
      a inc 1 if b < 5
      c dec -10 if a >= 1
      c inc -20 if c == 10
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the largest number in any register after running" do
      expect(solution).to eq(1)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the largest number in any register during runtime" do
      expect(solution).to eq(10)
    end
  end
end
