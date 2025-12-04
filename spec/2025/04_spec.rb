require "spec_helper"

RSpec.describe "Day 4: Printing Department" do
  let(:runner) { Runner.new("2025/04") }
  let(:input) do
    <<~TXT
      ..@@.@@@@.
      @@@.@.@.@@
      @@@@@.@.@@
      @.@@@@..@.
      @@.@@@@.@@
      .@@@@@@@.@
      .@.@.@.@@@
      @.@@@.@@@@
      .@@@@@@@@.
      @.@.@@@.@.
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the number of accessible rolls" do
      expect(solution).to eq(13)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the total number of removable rolls" do
      expect(solution).to eq(43)
    end
  end
end
