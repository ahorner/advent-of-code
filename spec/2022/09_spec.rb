require "spec_helper"

RSpec.describe "Day 9: Rope Bridge" do
  let(:runner) { Runner.new("2022/09") }
  let(:input) do
    <<~TXT
      R 4
      U 4
      L 3
      D 1
      R 4
      D 1
      L 5
      R 2
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "counts the rooms the tail visits at least once" do
      expect(solution).to eq(13)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "counts the rooms the 10-knot tail visits at least once" do
      expect(solution).to eq(1)
    end

    describe "for a larger example" do
      let(:input) do
        <<~TXT
          R 5
          U 8
          L 8
          D 3
          R 17
          D 10
          L 25
          U 20
        TXT
      end

      it "counts the rooms the 10-knot tail visits at least once" do
        expect(solution).to eq(36)
      end
    end
  end
end
