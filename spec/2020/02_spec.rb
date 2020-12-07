require "spec_helper"

describe "Day 2: Password Philosophy" do
  let(:runner) { Runner.new("2020/02") }
  let(:input) do
    <<~TXT
      1-3 a: abcde
      1-3 b: cdefg
      2-9 c: ccccccccc
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "validates passwords" do
      expect(solution).to eq(2)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "validates passwords using positional values" do
      expect(solution).to eq(1)
    end
  end
end
