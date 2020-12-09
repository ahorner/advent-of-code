require "spec_helper"

RSpec.describe "Day 9: Encoding Error" do
  let(:runner) { Runner.new("2020/09") }
  let(:input) do
    <<~TXT
      35
      20
      15
      25
      47
      40
      62
      55
      65
      95
      102
      117
      150
      182
      127
      219
      299
      277
      309
      576
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, PREAMBLE: 5) }

    it "finds the first number that doesn't fit its preamble" do
      expect(solution).to eq(127)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2, PREAMBLE: 5) }

    it "finds the encryption weakness" do
      expect(solution).to eq(62)
    end
  end
end
