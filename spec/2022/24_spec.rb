require "spec_helper"

RSpec.describe "Day 24: Blizzard Basin" do
  let(:runner) { Runner.new("2022/24") }
  let(:input) do
    <<~TXT
      #.######
      #>>.<^<#
      #.<..<<#
      #>v.><>#
      #<^v^^>#
      ######.#
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the fastest route through the blizzards" do
      expect(solution).to eq(18)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the total time with a return trip" do
      expect(solution).to eq(54)
    end
  end
end
