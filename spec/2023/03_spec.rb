require "spec_helper"

RSpec.describe "Day 3: Gear Ratios" do
  let(:runner) { Runner.new("2023/03") }
  let(:input) do
    <<~TXT
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "sums the part numbers from the schematic" do
      expect(solution).to eq(4361)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "sums the gear ratios from the schematic" do
      expect(solution).to eq(467835)
    end
  end
end
