require "spec_helper"

describe "Day 6: Probably a Fire Hazard" do
  let(:runner) { Runner.new("2015/06") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }
    let(:input) do
      <<~TXT
        turn on 0,0 through 999,999
        toggle 0,0 through 999,0
        turn off 499,499 through 500,500
      TXT
    end

    it "counts the active lights after running" do
      expect(solution).to eq(1_000_000 - 1_000 - 4)
    end

  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }
    let(:input) do
      <<~TXT
        turn on 0,0 through 0,0
        toggle 0,0 through 999,999
      TXT
    end

    it "calculates the total brightness" do
      expect(solution).to eq(2_000_000 + 1)
    end
  end
end
