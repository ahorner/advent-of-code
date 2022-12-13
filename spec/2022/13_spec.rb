require "spec_helper"

RSpec.describe "Day 13: Distress Signal" do
  let(:runner) { Runner.new("2022/13") }
  let(:input) do
    <<~TXT
      [1,1,3,1,1]
      [1,1,5,1,1]

      [[1],[2,3,4]]
      [[1],4]

      [9]
      [[8,7,6]]

      [[4,4],4,4]
      [[4,4],4,4,4]

      [7,7,7,7]
      [7,7,7]

      []
      [3]

      [[[]]]
      [[]]

      [1,[2,[3,[4,[5,6,7]]]],8,9]
      [1,[2,[3,[4,[5,6,0]]]],8,9]
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "sums the indices of correctly-ordered pairs" do
      expect(solution).to eq(13)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the decoder key for the ordered packets" do
      expect(solution).to eq(140)
    end
  end
end
