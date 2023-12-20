require "spec_helper"

RSpec.describe "Day 20: Pulse Propagation" do
  let(:runner) { Runner.new("2023/20") }

  describe "Part One" do
    it "calculates the numbers of low and high pulses" do
      expect(runner.execute!(<<~TXT, part: 1)).to eq(32000000)
        broadcaster -> a, b, c
        %a -> b
        %b -> c
        %c -> inv
        &inv -> a
      TXT

      expect(runner.execute!(<<~TXT, part: 1)).to eq(11687500)
        broadcaster -> a
        %a -> inv, con
        &inv -> b
        %b -> con
        &con -> output
      TXT
    end
  end

  describe "Part Two" do
    it "finds the number of presses needed to activate the receiver" do
      expect(runner.execute!(<<~TXT, part: 2)).to eq(1)
        broadcaster -> a, b
        %a -> b, c
        %b -> c, d
        &c -> d, e
        &d -> e
        &e -> rx
      TXT

      expect(runner.execute!(<<~TXT, part: 2)).to eq(4)
        broadcaster -> a
        %a -> b, c
        %b -> d, e
        %c -> e
        &d -> e
        &e -> rx
      TXT
    end
  end
end
