require "spec_helper"

RSpec.describe "Day 17: Two Steps Forward" do
  let(:runner) { Runner.new("2016/17") }

  describe "Part One" do
    it "finds the shortest path for a passcode" do
      expect(runner.execute!("ihgpwlah", part: 1)).to eq("DDRRRD")
      expect(runner.execute!("kglvqrro", part: 1)).to eq("DDUDRLRRUDRD")
      expect(runner.execute!("ulqzkmiv", part: 1)).to eq("DRURDRUDDLLDLUURRDULRLDUUDDDRR")
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input) }

    it "computes the maximum path length for a passcode" do
      expect(runner.execute!("ihgpwlah", part: 2)).to eq(370)
      expect(runner.execute!("kglvqrro", part: 2)).to eq(492)
      expect(runner.execute!("ulqzkmiv", part: 2)).to eq(830)
    end
  end
end
