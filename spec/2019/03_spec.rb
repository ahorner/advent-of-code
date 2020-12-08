require "spec_helper"

RSpec.describe "Day 3: Crossed Wires" do
  let(:runner) { Runner.new("2019/03") }

  describe "Part One" do
    it "finds the closest intersection" do
      expect(runner.execute!(<<~TXT, part: 1)).to eq(6)
        R8,U5,L5,D3
        U7,R6,D4,L4
      TXT
      expect(runner.execute!(<<~TXT, part: 1)).to eq(159)
        R75,D30,R83,U83,L12,D49,R71,U7,L72
        U62,R66,U55,R34,D71,R55,D58,R83
      TXT
      expect(runner.execute!(<<~TXT, part: 1)).to eq(135)
        R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
        U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
      TXT
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the closest intersection by wire steps" do
      expect(runner.execute!(<<~TXT, part: 2)).to eq(30)
        R8,U5,L5,D3
        U7,R6,D4,L4
      TXT
      expect(runner.execute!(<<~TXT, part: 2)).to eq(610)
        R75,D30,R83,U83,L12,D49,R71,U7,L72
        U62,R66,U55,R34,D71,R55,D58,R83
      TXT
      expect(runner.execute!(<<~TXT, part: 2)).to eq(410)
        R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
        U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
      TXT
    end
  end
end
