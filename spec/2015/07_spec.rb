require "spec_helper"

describe "Day 7: Some Assembly Required" do
  let(:runner) { Runner.new("2015/07") }
  let(:input) do
    <<~TXT
      123 -> x
      456 -> y
      x AND y -> d
      x OR y -> e
      x LSHIFT 2 -> f
      y RSHIFT 2 -> g
      NOT x -> h
      NOT y -> i
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, WIRE: "i") }

    it "finds the signal on the target wire" do
      expect(solution).to eq(65_079)
    end
  end
end
