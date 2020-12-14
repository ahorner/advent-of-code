require "spec_helper"

RSpec.describe "Day 14: Docking Data" do
  let(:runner) { Runner.new("2020/14") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }
    let(:input) do
      <<~TXT
        mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
        mem[8] = 11
        mem[7] = 101
        mem[8] = 0
      TXT
    end

    it "sums the final memory values after input masking" do
      expect(solution).to eq(165)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }
    let(:input) do
      <<~TXT
        mask = 000000000000000000000000000000X1001X
        mem[42] = 100
        mask = 00000000000000000000000000000000X0XX
        mem[26] = 1
      TXT
    end

    it "sums the final memory values after address masking" do
      expect(solution).to eq(208)
    end
  end
end
