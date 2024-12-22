require "spec_helper"

RSpec.describe "Day 22: Monkey Market" do
  let(:runner) { Runner.new("2024/22") }
  let(:input) do
    <<~TXT
      1
      10
      100
      2024
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "totals the secret numbers for all buyers" do
      expect(solution).to eq(37327623)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }
    let(:input) do
      <<~TXT
        1
        2
        3
        2024
      TXT
    end

    it "finds the maximum buyable bananas" do
      expect(solution).to eq(23)
    end
  end
end
