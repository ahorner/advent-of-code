require "spec_helper"

RSpec.describe "Day 17: Clumsy Crucible" do
  let(:runner) { Runner.new("2023/17") }
  let(:input) do
    <<~TXT
      2413432311323
      3215453535623
      3255245654254
      3446585845452
      4546657867536
      1438598798454
      4457876987766
      3637877979653
      4654967986887
      4564679986453
      1224686865563
      2546548887735
      4322674655533
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the minimum heat loss for the trip" do
      expect(solution).to eq(102)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the minimum heat loss for an ultra crucible" do
      expect(solution).to eq(94)
    end

    describe "for a different city map" do
      let(:input) do
        <<~TXT
          111111111111
          999999999991
          999999999991
          999999999991
          999999999991
        TXT
      end

      it "still calculates the minimum ultra crucible heat loss" do
        expect(solution).to eq(71)
      end
    end
  end
end
