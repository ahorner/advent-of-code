require "spec_helper"

RSpec.describe "Day 22: Sand Slabs" do
  let(:runner) { Runner.new("2023/22") }
  let(:input) do
    <<~TXT
      1,0,1~1,2,1
      0,0,2~2,0,2
      0,2,3~2,2,3
      0,0,4~0,2,4
      2,0,5~2,2,5
      0,1,6~2,1,6
      1,1,8~1,1,9
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the number of bricks that can be disintegrated" do
      expect(solution).to eq(5)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the total number of brick falls" do
      expect(solution).to eq(7)
    end
  end
end
