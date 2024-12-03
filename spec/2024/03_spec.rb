require "spec_helper"

RSpec.describe "Day 3: Mull It Over" do
  let(:runner) { Runner.new("2024/03") }

  describe "Part One" do
    let(:input) { "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))" }
    let(:solution) { runner.execute!(input, part: 1) }

    it "sums all valid `mul` instructions" do
      expect(solution).to eq(161)
    end
  end

  describe "Part Two" do
    let(:input) { "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))" }
    let(:solution) { runner.execute!(input, part: 2) }

    it "sums only enabled `mul` instructions" do
      expect(solution).to eq(48)
    end
  end
end
