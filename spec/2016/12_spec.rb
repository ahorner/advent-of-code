require "spec_helper"

RSpec.describe "Day 12: Leonardo's Monorail" do
  let(:runner) { Runner.new("2016/12") }
  let(:input) do
    <<~TXT
      cpy 41 a
      inc a
      inc a
      dec a
      jnz a 2
      dec a
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "computes the final value of register a" do
      expect(solution).to eq(42)
    end
  end
end
