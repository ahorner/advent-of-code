require "spec_helper"

RSpec.describe "Day 7: The Treachery of Whales" do
  let(:runner) { Runner.new("2021/07") }
  let(:input) do
    <<~TXT
      16,1,2,0,4,2,7,1,2,14
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the minimum fuel necessary for aligment" do
      expect(solution).to eq(37)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the minimum fuel with increasing costs" do
      expect(solution).to eq(168)
    end
  end
end
