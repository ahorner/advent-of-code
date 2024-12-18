require "spec_helper"

RSpec.describe "Day 18: RAM Run" do
  let(:runner) { Runner.new("2024/18") }
  let(:input) do
    <<~TXT
      5,4
      4,2
      4,5
      3,0
      2,1
      6,3
      2,4
      1,5
      0,6
      3,3
      2,6
      5,1
      1,2
      5,5
      2,5
      6,5
      1,4
      0,4
      6,4
      1,1
      6,1
      1,0
      0,5
      1,6
      2,0
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, SIZE: 7, TIME: 12) }

    it "calculates the minimum number of steps to the exit" do
      expect(solution).to eq(22)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2, SIZE: 7, TIME: 12) }

    it "finds the first byte that blocks the exit" do
      expect(solution).to eq("6,1")
    end
  end
end
