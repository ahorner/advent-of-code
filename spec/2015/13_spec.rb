require "spec_helper"

describe "Day 13: Knights of the Dinner Table" do
  let(:runner) { Runner.new("2015/13") }
  let(:input) do
    <<~TXT
      Alice would gain 54 happiness units by sitting next to Bob.
      Alice would lose 79 happiness units by sitting next to Carol.
      Alice would lose 2 happiness units by sitting next to David.
      Bob would gain 83 happiness units by sitting next to Alice.
      Bob would lose 7 happiness units by sitting next to Carol.
      Bob would lose 63 happiness units by sitting next to David.
      Carol would lose 62 happiness units by sitting next to Alice.
      Carol would gain 60 happiness units by sitting next to Bob.
      Carol would gain 55 happiness units by sitting next to David.
      David would gain 46 happiness units by sitting next to Alice.
      David would lose 7 happiness units by sitting next to Bob.
      David would gain 41 happiness units by sitting next to Carol.
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the most optimal arrangement" do
      expect(solution).to eq(330)
    end
  end
end
