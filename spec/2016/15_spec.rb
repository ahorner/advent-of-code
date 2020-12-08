require "spec_helper"

RSpec.describe "Day 15: Timing is Everything" do
  let(:runner) { Runner.new("2016/15") }
  let(:input) do
    <<~TXT
      Disc #1 has 5 positions; at time=0, it is at position 4.
      Disc #2 has 2 positions; at time=0, it is at position 1.
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the minimum delay to get a capsule" do
      expect(solution).to eq(5)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the minimum delay with an additional disk" do
      expect(solution).to eq(85)
    end
  end
end
