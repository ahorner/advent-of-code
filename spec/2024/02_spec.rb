require "spec_helper"

RSpec.describe "Day 2: Red-Nosed Reports" do
  let(:runner) { Runner.new("2024/02") }
  let(:input) do
    <<~TXT
      7 6 4 2 1
      1 2 7 8 9
      9 7 6 2 1
      1 3 2 4 5
      8 6 4 4 1
      1 3 6 7 9
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "counts the number of safe reports" do
      expect(solution).to eq(2)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "counts the number of safe reports with the tolerace module" do
      expect(solution).to eq(4)
    end
  end
end
