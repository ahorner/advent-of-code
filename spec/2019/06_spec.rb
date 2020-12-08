require "spec_helper"

describe "Day 6: Universal Orbit Map" do
  let(:runner) { Runner.new("2019/06") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }
    let(:input) do
      <<~TXT
        COM)B
        B)C
        C)D
        D)E
        E)F
        B)G
        G)H
        D)I
        E)J
        J)K
        K)L
      TXT
    end

    it "calculates the number of orbits" do
      expect(solution).to eq(42)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }
    let(:input) do
      <<~TXT
        COM)B
        B)C
        C)D
        D)E
        E)F
        B)G
        G)H
        D)I
        E)J
        J)K
        K)L
        K)YOU
        I)SAN
      TXT
    end

    it "calculates the minimum number of orbital transfers" do
      expect(solution).to eq(4)
    end
  end
end
