require "spec_helper"

RSpec.describe "Day 12: Rain Risk" do
  let(:runner) { Runner.new("2020/12") }
  let(:input) do
    <<~TXT
      F10
      N3
      F7
      R90
      F11
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the distance to the final location" do
      expect(solution).to eq(25)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the distance after following the waypoint" do
      expect(solution).to eq(286)
    end
  end
end
