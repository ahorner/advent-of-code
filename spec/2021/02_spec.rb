require "spec_helper"

RSpec.describe "Day 2: Dive!" do
  let(:runner) { Runner.new("2021/02") }
  let(:input) do
    <<~TXT
      forward 5
      down 5
      forward 8
      up 3
      down 8
      forward 2
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the proper combined depth and position" do
      expect(solution).to eq(150)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the proper combined depth and position" do
      expect(solution).to eq(900)
    end
  end
end
