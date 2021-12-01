require "spec_helper"

RSpec.describe "Day 1: Sonar Sweep" do
  let(:runner) { Runner.new("2021/01") }
  let(:input) do
    <<~TXT
      199
      200
      208
      210
      200
      207
      240
      269
      260
      263
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "counts the number of increases" do
      expect(solution).to eq(7)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "counts the number of 3-measurement increases" do
      expect(solution).to eq(5)
    end
  end
end
