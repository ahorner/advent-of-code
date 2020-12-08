require "spec_helper"

describe "Day 19: Go With The Flow" do
  let(:runner) { Runner.new("2018/19") }
  let(:input) do
    <<~TXT
      #ip 0
      seti 5 0 1
      seti 6 0 2
      addi 0 1 0
      addr 1 2 3
      setr 1 0 0
      seti 8 0 4
      seti 9 0 5
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "determines the final value of register 0" do
      expect(solution).to eq(6 + 1)
    end
  end
end
