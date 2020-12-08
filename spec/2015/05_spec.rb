require "spec_helper"

RSpec.describe "Day 5: Doesn't He Have Intern-Elves For This?" do
  let(:runner) { Runner.new("2015/05") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }
    let(:input) do
      <<~TXT
        ugknbfddgicrmopn
        aaa
        jchzalrnumimnmhp
        haegwjzuvuyypxyu
        dvszwmarrgswjxmb
      TXT
    end

    it "counts the number of nice strings" do
      expect(solution).to eq(2)
    end

    it "tests strings for niceness" do
      tests = input.split("\n").map { |string| runner.execute!(string, part: 1) }
      expect(tests).to eq([1, 1, 0, 0, 0])
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }
    let(:input) do
      <<~TXT
        qjhvhtzxzqqjkmpb
        xxyxx
        uurcxstgmygtbstg
        ieodomkazucvgmuy
      TXT
    end

    it "counts the new number of nice strings" do
      expect(solution).to eq(2)
    end

    it "tests strings for niceness" do
      tests = input.split("\n").map { |string| runner.execute!(string, part: 2) }
      expect(tests).to eq([1, 1, 0, 0])
    end
  end
end
