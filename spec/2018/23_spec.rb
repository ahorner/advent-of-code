require "spec_helper"

RSpec.describe "Day 23: Experimental Emergency Teleportation" do
  let(:runner) { Runner.new("2018/23") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }
    let(:input) do
      <<~TXT
        pos=<0,0,0>, r=4
        pos=<1,0,0>, r=1
        pos=<4,0,0>, r=3
        pos=<0,2,0>, r=1
        pos=<0,5,0>, r=3
        pos=<0,0,3>, r=1
        pos=<1,1,1>, r=1
        pos=<1,1,2>, r=1
        pos=<1,3,1>, r=1
      TXT
    end

    it "counts nanobots within the largest signal range" do
      expect(solution).to eq(7)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }
    let(:input) do
      <<~TXT
        pos=<10,12,12>, r=2
        pos=<12,14,12>, r=2
        pos=<16,12,12>, r=4
        pos=<14,14,14>, r=6
        pos=<50,50,50>, r=200
        pos=<10,10,10>, r=5
      TXT
    end

    it "finds the distance to the most popular nanobot" do
      expect(solution).to eq(36)
    end
  end
end
