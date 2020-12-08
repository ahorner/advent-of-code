require "spec_helper"

RSpec.describe "Day 25: Four-Dimensional Adventure" do
  let(:runner) { Runner.new("2018/25") }

  describe "Part One" do
    it "calculates the final number of constellations" do
      expect(runner.execute!(<<~TXT, part: 1)).to eq(2)
        0,0,0,0
        3,0,0,0
        0,3,0,0
        0,0,3,0
        0,0,0,3
        0,0,0,6
        9,0,0,0
        12,0,0,0
      TXT
      expect(runner.execute!(<<~TXT, part: 1)).to eq(4)
        -1,2,2,0
        0,0,2,-2
        0,0,0,-2
        -1,2,0,0
        -2,-2,-2,2
        3,0,2,-1
        -1,3,2,2
        -1,0,-1,0
        0,2,1,-2
        3,0,0,0
      TXT
      expect(runner.execute!(<<~TXT, part: 1)).to eq(3)
        1,-1,0,1
        2,0,-1,0
        3,2,-1,0
        0,0,3,1
        0,0,-1,-1
        2,3,-2,0
        -2,2,0,0
        2,-2,0,-1
        1,-1,0,-1
        3,2,0,2
      TXT
      expect(runner.execute!(<<~TXT, part: 1)).to eq(8)
        1,-1,-1,-2
        -2,-2,0,1
        0,2,1,3
        -2,3,-2,1
        0,2,3,-2
        -1,-1,1,-2
        0,-2,-1,0
        -2,2,3,-1
        1,2,2,0
        -1,-2,0,-2
      TXT
    end
  end
end
