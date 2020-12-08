require "spec_helper"

describe "Day 5: How About a Nice Game of Chess?" do
  let(:runner) { Runner.new("2016/05") }
  let(:input) { "abc" }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "generates a password using the door ID" do
      expect(solution).to eq("18f47a30")
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "generates a positional password using the door ID" do
      expect(solution).to eq("05ace8e3")
    end
  end
end
