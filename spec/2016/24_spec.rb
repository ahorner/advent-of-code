require "spec_helper"

RSpec.describe "Day 24: Air Duct Spelunking" do
  let(:runner) { Runner.new("2016/24") }
  let(:input) do
    <<~TXT
      ###########
      #0.1.....2#
      #.#######.#
      #4.......3#
      ###########
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the minimum path to reach all goals" do
      expect(solution).to eq(14)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "factors a return to origin into the minimum path" do
      expect(solution).to eq(20)
    end
  end
end
