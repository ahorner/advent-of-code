require "spec_helper"

RSpec.describe "Day 14: Extended Polymerization" do
  let(:runner) { Runner.new("2021/14") }
  let(:input) do
    <<~TXT
      NNCB

      CH -> B
      HH -> N
      CB -> H
      NH -> C
      HB -> C
      HC -> B
      HN -> C
      NN -> C
      BH -> H
      NC -> B
      NB -> B
      BN -> B
      BB -> N
      BC -> B
      CC -> N
      CN -> C
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "computes the difference between the most and least common elements" do
      expect(solution).to eq(1_588)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }
  end
end
