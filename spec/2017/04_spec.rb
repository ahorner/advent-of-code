require "spec_helper"

RSpec.describe "Day 4: High-Entropy Passphrases" do
  let(:runner) { Runner.new("2017/04") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }
    let(:input) do
      <<~TXT
        aa bb cc dd ee
        aa bb cc dd aa
        aa bb cc dd aaa
      TXT
    end

    it "tests passphrases for validity" do
      tests = input.split("\n").map { |line| runner.execute!(line, part: 1) }
      expect(tests).to eq([1, 0, 1])
    end

    it "counts the number of valid passphrases" do
      expect(solution).to eq(2)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }
    let(:input) do
      <<~TXT
        abcde fghij
        abcde xyz ecdab
        a ab abc abd abf abj
        iiii oiii ooii oooi oooo
        oiii ioii iioi iiio
      TXT
    end

    it "tests passphrases for anagram validity" do
      tests = input.split("\n").map { |line| runner.execute!(line, part: 2) }
      expect(tests).to eq([1, 0, 1, 1, 0])
    end

    it "counts the number of valid passphrases without anagrams" do
      expect(solution).to eq(3)
    end
  end
end
