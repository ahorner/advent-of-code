require "spec_helper"

describe "Day 7: Internet Protocol Version 7" do
  let(:runner) { Runner.new("2016/07") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }
    let(:input) do
      <<~TXT
        abba[mnop]qrst
        abcd[bddb]xyyx
        aaaa[qwer]tyui
        ioxxoj[asdfgh]zxcvbn
      TXT
    end

    it "properly tests IPs for TLS support" do
      tests = input.split("\n").map { |line| runner.execute!(line, part: 1) }
      expect(tests).to eq([1, 0, 0, 1])
    end

    it "counts the IPs that support TLS" do
      expect(solution).to eq(2)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }
    let(:input) do
      <<~TXT
        aba[bab]xyz
        xyx[xyx]xyx
        aaa[kek]eke
        zazbz[bzb]cdb
      TXT
    end

    it "properly tests IPs for SSL support" do
      tests = input.split("\n").map { |line| runner.execute!(line, part: 2) }
      expect(tests).to eq([1, 0, 1, 1])
    end

    it "counts the IPs that support SSL" do
      expect(solution).to eq(3)
    end
  end
end
