require "spec_helper"

RSpec.describe "Day 1: Secret Entrance" do
  let(:runner) { Runner.new("2025/01") }
  let(:input) do
    <<~TXT
      L68
      L30
      R48
      L5
      R60
      L55
      L1
      L99
      R14
      L82
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the password from the number of zeroes" do
      expect(solution).to eq(3)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the password including clicks" do
      expect(solution).to eq(6)
    end

    it "handles edge case with exact range movements" do
      edge_case_input = <<~TXT
        R100
        L100
        R200
        L200
      TXT

      edge_case_solution = runner.execute!(edge_case_input, part: 2)
      expect(edge_case_solution).to eq(6)
    end
  end
end
