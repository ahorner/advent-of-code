require "spec_helper"

describe "Day 21: RPG Simulator 20XX" do
  let(:runner) { Runner.new("2015/21") }
  let(:input) do
    <<~TXT
    TXT
  end

  describe "Part One" do
    let(:input) { "Hit Points: 12\nDamage: 7\nArmor: 2" }

    it "determines the minimum cost of victory" do
      expect(runner.execute!(input, part: 1, HERO_STATS: [8, 5, 5])).to eq(0)
      expect(runner.execute!(input, part: 1, HERO_STATS: [8, 1, 5])).to eq(8)
      expect(runner.execute!(input, part: 1, HERO_STATS: [6, 1, 4])).to eq(23)
    end
  end
end
