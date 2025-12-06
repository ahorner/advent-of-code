require "spec_helper"

RSpec.describe "Day 6: Trash Compactor" do
  let(:runner) { Runner.new("2025/06") }
  let(:input) do
    <<~TXT
      123 328  51 64
       45 64  387 23
        6 98  215 314
      *   +   *   +
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates the grand total of all problems" do
      expect(solution).to eq(4277556)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the right-to-left total" do
      expect(solution).to eq(3263827)
    end
  end
end
