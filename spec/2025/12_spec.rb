require "spec_helper"

RSpec.describe "Day 12: Christmas Tree Farm" do
  let(:runner) { Runner.new("2025/12") }
  let(:input) do
    <<~TXT
      0:
      ###
      ##.
      ##.

      1:
      ###
      ##.
      .##

      2:
      .##
      ###
      ##.

      3:
      ##.
      ###
      ##.

      4:
      ###
      #..
      ###

      5:
      ###
      .#.
      ###

      4x4: 0 0 0 0 2 0
      12x5: 1 0 1 0 2 2
      12x5: 1 0 1 0 3 2
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the number of regions that can fit all presents" do
      expect(solution).to eq(2)
    end
  end
end
