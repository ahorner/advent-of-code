require "spec_helper"

describe "Day 15: Science for Hungry People" do
  let(:runner) { Runner.new("2015/15") }
  let(:input) do
    <<~TXT
      Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
      Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the score for the optimal cookie" do
      expect(solution).to eq(62_842_880)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the score for the optimal calorie-conscious cookie" do
      expect(solution).to eq(57_600_000)
    end
  end
end
