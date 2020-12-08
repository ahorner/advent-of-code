require "spec_helper"

RSpec.describe "Day 11: Chronal Charge" do
  let(:runner) { Runner.new("2018/11") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }
    let(:input) { "18" }

    it "finds the 3x3 square with the highest power" do
      expect(solution).to eq("33,45")
    end
  end

  describe "Part Two" do
    it "finds the square with maximum power" do
      expect(runner.execute!("18", part: 2)).to eq("90,269,16")
      expect(runner.execute!("42", part: 2)).to eq("232,251,12")
    end
  end
end
