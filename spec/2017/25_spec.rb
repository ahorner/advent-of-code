require "spec_helper"

RSpec.describe "Day 25: The Halting Problem" do
  let(:runner) { Runner.new("2017/25") }
  let(:input) do
    <<~TXT
      Begin in state A.
      Perform a diagnostic checksum after 6 steps.

      In state A:
        If the current value is 0:
          - Write the value 1.
          - Move one slot to the right.
          - Continue with state B.
        If the current value is 1:
          - Write the value 0.
          - Move one slot to the left.
          - Continue with state B.

      In state B:
        If the current value is 0:
          - Write the value 1.
          - Move one slot to the left.
          - Continue with state A.
        If the current value is 1:
          - Write the value 1.
          - Move one slot to the right.
          - Continue with state A.
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "calculates a diagnostic checksum" do
      expect(solution).to eq 3
    end
  end
end
