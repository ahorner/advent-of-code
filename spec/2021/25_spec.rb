require "spec_helper"

RSpec.describe "Day 25: Sea Cucumber" do
  let(:runner) { Runner.new("2021/25") }
  let(:input) do
    <<~TXT
      v...>>.vv>
      .vv>>.vv..
      >>.>v>...v
      >>v>>.>.v.
      v>v.vv.v..
      >.>>..v...
      .vv..>.>v.
      v.v..>>v.v
      ....v..v.>
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the first step at which the cucumbers stop moving" do
      expect(solution).to eq(58)
    end
  end
end
