require "spec_helper"

describe "Day 3: Squares With Three Sides" do
  let(:runner) { Runner.new("2016/03") }
  let(:input) do
    <<~TXT
      101 301 501
      102 302 502
      103 303 503
      201 401 601
      202 402 602
      203 403 603
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "computes the number of possible triangles" do
      expect(solution).to eq(3)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "computes the number of possible vertically-arrange triangles" do
      expect(solution).to eq(6)
    end
  end
end
