require "spec_helper"

RSpec.describe "Day 16: Ticket Translation" do
  let(:runner) { Runner.new("2020/16") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }
    let(:input) do
      <<~TXT
        class: 1-3 or 5-7
        row: 6-11 or 33-44
        seat: 13-40 or 45-50

        your ticket:
        7,1,14

        nearby tickets:
        7,3,47
        40,4,50
        55,2,20
        38,6,12
      TXT
    end

    it "finds the scanning error rate by summing invalid fields" do
      expect(solution).to eq(71)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }
    let(:input) do
      # NOTE: I've tweaked this slightly so it produces a usable output based on
      # the challenge's criteria.
      <<~TXT
        departure class: 0-1 or 4-19
        departure row: 0-5 or 8-19
        seat: 0-13 or 16-19

        your ticket:
        11,12,13

        nearby tickets:
        3,9,18
        15,1,5
        5,14,9
      TXT
    end

    it "determines the 'departure' value product" do
      expect(solution).to eq(12 * 11)
    end
  end
end
