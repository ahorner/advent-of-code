require "spec_helper"

RSpec.describe "Day 14: Restroom Redoubt" do
  let(:runner) { Runner.new("2024/14") }
  let(:input) do
    <<~TXT
      p=0,4 v=3,-3
      p=6,3 v=-1,-3
      p=10,3 v=-1,2
      p=2,0 v=2,-1
      p=0,0 v=1,3
      p=3,0 v=-2,-2
      p=7,6 v=-1,-3
      p=3,0 v=-1,-2
      p=9,3 v=2,3
      p=7,3 v=-1,2
      p=2,4 v=2,-3
      p=9,5 v=-3,-3
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, WIDTH: 11, HEIGHT: 7) }

    it "calculates the safety factor" do
      expect(solution).to eq(12)
    end
  end
end
