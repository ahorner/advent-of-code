require "spec_helper"

RSpec.describe "Day 23: Opening the Turing Lock" do
  let(:runner) { Runner.new("2015/23") }
  let(:input) do
    <<~TXT
      inc a
      jio a, +2
      tpl a
      inc a
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, REGISTER: "a") }

    it "calculates the final value of the target register" do
      expect(solution).to eq(2)
    end
  end
end
