require "spec_helper"

describe "Day 22: Wizard Simulator 20XX" do
  let(:runner) { Runner.new("2015/22") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, HERO_STATS: [10, 0, 250]) }
    let(:input) { "Hit Points: 13\nDamage: 8" }

    it "finds the optimal strategy" do
      expect(solution).to eq(226)
    end

    describe "for a harder battle" do
      let(:input) {  "Hit Points: 14\nDamage: 8" }

      it "finds the optimal strategy" do
        expect(solution).to eq(641)
      end
    end
  end
end
