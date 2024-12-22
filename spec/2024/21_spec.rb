require "spec_helper"

RSpec.describe "Day 21: Keypad Conundrum" do
  let(:runner) { Runner.new("2024/21") }
  let(:input) do
    <<~TXT
      029A
      980A
      179A
      456A
      379A
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the complexity of each code" do
      expect(solution).to eq(126384)
    end
  end
end
