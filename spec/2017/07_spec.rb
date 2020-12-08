require "spec_helper"

RSpec.describe "Day 7: Recursive Circus" do
  let(:runner) { Runner.new("2017/07") }
  let(:input) do
    <<~TXT
      pbga (66)
      xhth (57)
      ebii (61)
      havc (66)
      ktlj (57)
      fwft (72) -> ktlj, cntj, xhth
      qoyq (66)
      padx (45) -> pbga, havc, qoyq
      tknk (41) -> ugml, padx, fwft
      jptl (61)
      ugml (68) -> gyxo, ebii, jptl
      gyxo (61)
      cntj (57)
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the bottom of the tower" do
      expect(solution).to eq("tknk")
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the necessary weight to balance the tower" do
      expect(solution).to eq(60)
    end
  end
end
