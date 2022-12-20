require "spec_helper"

RSpec.describe "Day 20: Grove Positioning System" do
  let(:runner) { Runner.new("2022/20") }
  let(:input) do
    <<~TXT
      1
      2
      -3
      3
      -2
      0
      4
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the grove coordinates" do
      expect(solution).to eq(3)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the grove checksum" do
      expect(solution).to eq(1623178306)
    end
  end
end
