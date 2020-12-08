require "spec_helper"

describe "Day 9: Stream Processing" do
  let(:runner) { Runner.new("2017/09") }

  describe "Part One" do
    it "properly scores groups in the input" do
      expect(runner.execute!("{}", part: 1)).to eq(1)
      expect(runner.execute!("{{{}}}", part: 1)).to eq(6)
      expect(runner.execute!("{{},{}}", part: 1)).to eq(5)
      expect(runner.execute!("{{{},{},{{}}}}", part: 1)).to eq(16)
      expect(runner.execute!("{<a>,<a>,<a>,<a>}", part: 1)).to eq(1)
      expect(runner.execute!("{{<ab>},{<ab>},{<ab>},{<ab>}}", part: 1)).to eq(9)
      expect(runner.execute!("{{<!!>},{<!!>},{<!!>},{<!!>}}", part: 1)).to eq(9)
      expect(runner.execute!("{{<a!>},{<a!>},{<a!>},{<ab>}}", part: 1)).to eq(3)
    end
  end

  describe "Part Two" do
    it "counts non-cancelled characters" do
      expect(runner.execute!("<>", part: 2)).to eq(0)
      expect(runner.execute!("<random characters>", part: 2)).to eq(17)
      expect(runner.execute!("<<<<>", part: 2)).to eq(3)
      expect(runner.execute!("<{!>}>", part: 2)).to eq(2)
      expect(runner.execute!("<!!>", part: 2)).to eq(0)
      expect(runner.execute!("<!!!>>", part: 2)).to eq(0)
      expect(runner.execute!("<{o\"i!a,<{i<a>", part: 2)).to eq(10)
    end
  end
end
