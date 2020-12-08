require "spec_helper"

describe "Day 21: Fractal Art" do
  let(:runner) { Runner.new("2017/21") }
  let(:input) do
    <<~TXT
      ../.# => ##./#../...
      .#./..#/### => #..#/..../..../#..#
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, ITERATIONS: 2) }

    it "computes the number of pixels that remain on" do
      expect(solution).to eq(12)
    end
  end
end
