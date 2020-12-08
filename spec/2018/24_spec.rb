require "spec_helper"

RSpec.describe "Day 24: Immune System Simulator 20XX" do
  let(:runner) { Runner.new("2018/24") }
  let(:input) do
    <<~TXT
      Immune System:
      17 units each with 5390 hit points (weak to radiation, bludgeoning) with an attack that does 4507 fire damage at initiative 2
      989 units each with 1274 hit points (immune to fire; weak to bludgeoning, slashing) with an attack that does 25 slashing damage at initiative 3

      Infection:
      801 units each with 4706 hit points (weak to radiation) with an attack that does 116 bludgeoning damage at initiative 1
      4485 units each with 2961 hit points (immune to radiation; weak to fire, cold) with an attack that does 12 slashing damage at initiative 4
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "computes the final units in the winning army" do
      expect(solution).to eq(5216)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "determines units left after a minimal boost to the immune system" do
      expect(solution).to eq(51)
    end
  end
end
