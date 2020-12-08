require "spec_helper"

describe "Day 24: It Hangs in the Balance" do
  let(:runner) { Runner.new("2015/24") }
  let(:input) do
    <<~TXT
      1
      2
      3
      4
      5
      7
      8
      9
      10
      11
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "computes ideal quantum entanglement" do
      expect(solution).to eq(99)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "computes ideal quantum entanglement (with a trunk)" do
      expect(solution).to eq(44)
    end
  end
end
