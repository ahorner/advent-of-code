require "spec_helper"

RSpec.describe "Day 21: Scrambled Letters and Hash" do
  let(:runner) { Runner.new("2016/21") }
  let(:input) do
    <<~TXT
      swap position 4 with position 0
      swap letter d with letter b
      reverse positions 0 through 4
      rotate left 1 step
      move position 1 to position 4
      move position 3 to position 0
      rotate based on position of letter b
      rotate based on position of letter d
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, SCRAMBLE: %w[a b c d e]) }

    it "follows the instructions to scramble the code" do
      expect(solution).to eq("decab")
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2, UNSCRAMBLE: %w[d e c a b]) }

    it "follows the instructions to unscramble the code" do
      expect(solution).to eq("abcde")
    end
  end
end
