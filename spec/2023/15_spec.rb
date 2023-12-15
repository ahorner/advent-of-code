require "spec_helper"

RSpec.describe "Day 15: Lens Library" do
  let(:runner) { Runner.new("2023/15") }
  let(:input) do
    <<~TXT
      rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the verification code for the initialization sequence" do
      expect(solution).to eq(1320)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the total focusing power of the lenses" do
      expect(solution).to eq(145)
    end
  end
end
