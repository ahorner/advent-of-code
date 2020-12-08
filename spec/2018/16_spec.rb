require "spec_helper"

RSpec.describe "Day 16: Chronal Classification" do
  let(:runner) { Runner.new("2018/16") }
  let(:input) do
    <<~TXT
      Before: [3, 2, 1, 1]
      9 2 1 2
      After:  [3, 2, 2, 1]
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "counts instructions that behave like three or more opcodes" do
      expect(solution).to eq(1)
    end
  end
end
