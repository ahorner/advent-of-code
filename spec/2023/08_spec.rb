require "spec_helper"

RSpec.describe "Day 8: Haunted Wasteland" do
  let(:runner) { Runner.new("2023/08") }
  let(:input) do
    <<~TXT
      RL

      AAA = (BBB, CCC)
      BBB = (DDD, EEE)
      CCC = (ZZZ, GGG)
      DDD = (DDD, DDD)
      EEE = (EEE, EEE)
      GGG = (GGG, GGG)
      ZZZ = (ZZZ, ZZZ)
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the number of steps required to reach ZZZ" do
      expect(solution).to eq(2)
    end

    describe "when the puzzle requires repeated movements" do
      let(:input) do
        <<~TXT
          LLR

          AAA = (BBB, BBB)
          BBB = (AAA, ZZZ)
          ZZZ = (ZZZ, ZZZ)
        TXT
      end

      it "still finds the number of required steps" do
        expect(solution).to eq(6)
      end
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    describe "for a ghost map" do
      let(:input) do
        <<~TXT
          LR

          AAA = (ZZZ, ZZZ)
          11A = (11B, XXX)
          11B = (XXX, 11Z)
          11Z = (11B, XXX)
          22A = (22B, XXX)
          22B = (22C, 22C)
          22C = (22Z, 22Z)
          22Z = (22B, 22B)
          XXX = (XXX, XXX)
          ZZZ = (ZZZ, ZZZ)
        TXT
      end

      it "still finds the number of required steps" do
        expect(solution).to eq(6)
      end
    end
  end
end
