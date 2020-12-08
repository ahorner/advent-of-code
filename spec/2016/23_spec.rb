require "spec_helper"

describe "Day 23: Safe Cracking" do
  let(:runner) { Runner.new("2016/23") }
  let(:input) do
    <<~TXT
      cpy 2 a
      tgl a
      tgl a
      tgl a
      cpy 1 a
      dec a
      dec a
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "outputs the final value in register a" do
      expect(solution).to eq(3)
    end
  end
end
