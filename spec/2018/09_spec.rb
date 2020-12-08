require "spec_helper"

RSpec.describe "Day 9: Marble Mania" do
  let(:runner) { Runner.new("2018/09") }

  describe "Part One" do
    it "calculates high scores for marble rounds" do
      expect(runner.execute!("9 players; last marble is worth 25 points", part: 1)).to eq(32)
      expect(runner.execute!("10 players; last marble is worth 1618 points", part: 1)).to eq(8317)
      expect(runner.execute!("13 players; last marble is worth 7999 points", part: 1)).to eq(146_373)
      expect(runner.execute!("17 players; last marble is worth 1104 points", part: 1)).to eq(2764)
      expect(runner.execute!("21 players; last marble is worth 6111 points", part: 1)).to eq(54_718)
      expect(runner.execute!("30 players; last marble is worth 5807 points", part: 1)).to eq(37_305)
    end
  end
end
