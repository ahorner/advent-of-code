require "spec_helper"

RSpec.describe "Day 25: Combo Breaker" do
  let(:runner) { Runner.new("2020/25") }
  let(:input) do
    <<~TXT
      5764801
      17807724
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the encryption key" do
      expect(solution).to eq(14_897_079)
    end
  end
end
