require "spec_helper"

RSpec.describe "Day 8: Handheld Halting" do
  let(:runner) { Runner.new("2020/08") }
  let(:input) do
    <<~TXT
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      jmp -4
      acc +6
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "grabs the value of the accumulator before looping" do
      expect(solution).to eq(5)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "grabs the value of the accumulator after fixing code" do
      expect(solution).to eq(8)
    end
  end
end
