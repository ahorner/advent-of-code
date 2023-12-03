require "spec_helper"

RSpec.describe "Day 1: Trebuchet?!" do
  let(:runner) { Runner.new("2023/01") }
  let(:input) do
    <<~TXT
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "computes the sum of two-digit numbers" do
      expect(solution).to eq(142)
    end
  end

  describe "Part Two" do
    let(:input) do
      <<~TXT
        two1nine
        eightwothree
        abcone2threexyz
        xtwone3four
        4nineeightseven2
        zoneight234
        7pqrstsixteen
      TXT
    end
    let(:solution) { runner.execute!(input, part: 2) }

    it "computes the sum using words as numbers" do
      expect(solution).to eq(281)
    end
  end
end
