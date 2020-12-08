require "spec_helper"

describe "Day 8: Space Image Format" do
  let(:runner) { Runner.new("2019/08") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, WIDTH: 3, HEIGHT: 2) }
    let(:input) { "123456789012" }

    it "finds the layer with minimal zeroes" do
      expect(solution).to eq(1)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2, WIDTH: 2, HEIGHT: 2) }
    let(:input) { "0222112222120000" }

    it "renders the final screen from the layers" do
      expect(solution).to eq <<~TXT
        .#
        #.
      TXT
    end
  end
end
