require "spec_helper"

RSpec.describe "Day 5: Print Queue" do
  let(:runner) { Runner.new("2024/05") }
  let(:input) do
    <<~TXT
      47|53
      97|13
      97|61
      97|47
      75|29
      61|13
      75|53
      29|13
      97|29
      53|29
      61|53
      97|53
      61|29
      47|13
      75|47
      97|75
      47|61
      75|61
      47|29
      75|13
      53|13

      75,47,61,53,29
      97,61,53,29,13
      75,29,13
      75,97,47,61,53
      61,13,29
      97,13,75,29,47
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the sum of middle page numbers for valid updates" do
      expect(solution).to eq(143)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the sum of middle page numbers for corrected updates" do
      expect(solution).to eq(123)
    end
  end
end
