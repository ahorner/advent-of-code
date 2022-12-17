require "spec_helper"

RSpec.describe "Day 17: Pyroclastic Flow" do
  let(:runner) { Runner.new("2022/17") }
  let(:input) do
    <<~TXT
      >>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the tower height after 2022 rocks" do
      expect(solution).to eq(3068)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the tower height after 1000000000000 blocks" do
      expect(solution).to eq(1514285714288)
    end
  end
end
