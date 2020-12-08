require "spec_helper"

describe "Day 22: Mode Maze" do
  let(:runner) { Runner.new("2018/22") }
  let(:input) do
    <<~TXT
      depth: 510
      target: 10,10
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the total risk level" do
      expect(solution).to eq(114)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the minimum time to reach the target" do
      expect(solution).to eq(45)
    end
  end
end
