require "spec_helper"

describe "Day 17: Spinlock" do
  let(:runner) { Runner.new("2017/17") }
  let(:input) { "3" }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "determines the value after the last value written" do
      expect(solution).to eq(638)
    end
  end
end
