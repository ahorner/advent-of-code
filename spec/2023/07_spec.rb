require "spec_helper"

RSpec.describe "Day 7: Camel Cards" do
  let(:runner) { Runner.new("2023/07") }
  let(:input) do
    <<~TXT
      32T3K 765
      T55J5 684
      KK677 28
      KTJJT 220
      QQQJA 483
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the total winnings" do
      expect(solution).to eq(6440)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the total winnings with jokers" do
      expect(solution).to eq(5905)
    end
  end
end
