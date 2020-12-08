require "spec_helper"

RSpec.describe "Day 12: The N-Body Problem" do
  let(:runner) { Runner.new("2019/12") }

  describe "Part One" do
    it "calculates the total energy after N steps" do
      expect(runner.execute!(<<~TXT, part: 1, STEPS: 10)).to eq(179)
        <x=-1, y=0, z=2>
        <x=2, y=-10, z=-7>
        <x=4, y=-8, z=8>
        <x=3, y=5, z=-1>
      TXT
      expect(runner.execute!(<<~TXT, part: 1, STEPS: 100)).to eq(1_940)
        <x=-8, y=-10, z=0>
        <x=5, y=5, z=10>
        <x=2, y=-7, z=3>
        <x=9, y=-8, z=-3>
      TXT
    end
  end

  describe "Part Two" do
    it "calculates the total steps before a repetition" do
      expect(runner.execute!(<<~TXT, part: 2)).to eq(2_772)
        <x=-1, y=0, z=2>
        <x=2, y=-10, z=-7>
        <x=4, y=-8, z=8>
        <x=3, y=5, z=-1>
      TXT
      expect(runner.execute!(<<~TXT, part: 2)).to eq(4_686_774_924)
        <x=-8, y=-10, z=0>
        <x=5, y=5, z=10>
        <x=2, y=-7, z=3>
        <x=9, y=-8, z=-3>
      TXT
    end
  end
end
