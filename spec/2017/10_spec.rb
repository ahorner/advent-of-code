require "spec_helper"

RSpec.describe "Day 10: Knot Hash" do
  let(:runner) { Runner.new("2017/10") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, LIST_SIZE: 5) }
    let(:input) { "3,4,1,5" }

    it "multiplies the first two numbers in the list after knotting" do
      expect(solution).to eq(12)
    end
  end

  describe "Part Two" do
    it "computes knot hashes for input strings" do
      expect(runner.execute!("", part: 2)).to eq("a2582a3a0e66e6e86e3812dcb672a272")
      expect(runner.execute!("AoC 2017", part: 2)).to eq("33efeb34ea91902bb2f59c9920caa6cd")
      expect(runner.execute!("1,2,3", part: 2)).to eq("3efbe78a8d82f29979031a4aa0b16a9d")
      expect(runner.execute!("1,2,4", part: 2)).to eq("63960835bcdc130f0b66d7ff4f6a5a8e")
    end
  end
end
