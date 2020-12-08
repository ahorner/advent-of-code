require "spec_helper"

describe "Day 18: Duet" do
  let(:runner) { Runner.new("2017/18") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }
    let(:input) do
      <<~TXT
        set a 1
        add a 2
        mul a a
        mod a 5
        snd a
        set a 0
        rcv a
        jgz a -1
        set a 1
        jgz a -2
      TXT
    end

    it "recovers the frequency of the last sound played" do
      expect(solution).to eq(4)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }
    let(:input) do
      <<~TXT
        snd 1
        snd 2
        snd p
        rcv a
        rcv b
        rcv c
        rcv d
      TXT
    end

    it "counts the number of times Program 1 sent a value" do
      expect(solution).to eq(3)
    end
  end
end
