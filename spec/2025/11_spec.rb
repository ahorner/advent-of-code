require "spec_helper"

RSpec.describe "Day 11: Reactor" do
  let(:runner) { Runner.new("2025/11") }

  describe "Part One" do
    let(:input) do
      <<~TXT
        aaa: you hhh
        you: bbb ccc
        bbb: ddd eee
        ccc: ddd eee fff
        ddd: ggg
        eee: out
        fff: out
        ggg: out
        hhh: ccc fff iii
        iii: out
      TXT
    end
    let(:solution) { runner.execute!(input, part: 1) }

    it "counts all possible paths between `you` and `out`" do
      expect(solution).to eq(5)
    end
  end

  describe "Part Two" do
    let(:input) do
      <<~TXT
        svr: aaa bbb
        aaa: fft
        fft: ccc
        bbb: tty
        tty: ccc
        ccc: ddd eee
        ddd: hub
        hub: fff
        eee: dac
        dac: fff
        fff: ggg hhh
        ggg: out
        hhh: out
      TXT
    end
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the number of server paths that reach both `dac` and `fft`" do
      expect(solution).to eq(2)
    end
  end
end
