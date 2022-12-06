require "spec_helper"

RSpec.describe "Day 6: Tuning Trouble" do
  let(:runner) { Runner.new("2022/06") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the first start-of-packet marker" do
      expect(runner.execute!("mjqjpqmgbljsphdztnvjfqwrcgsmlb", part: 1)).to eq(7)
      expect(runner.execute!("bvwbjplbgvbhsrlpgdmjqwftvncz", part: 1)).to eq(5)
      expect(runner.execute!("nppdvjthqldpwncqszvftbrmjlhg", part: 1)).to eq(6)
      expect(runner.execute!("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", part: 1)).to eq(10)
      expect(runner.execute!("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", part: 1)).to eq(11)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the first start-of-message marker" do
      expect(runner.execute!("mjqjpqmgbljsphdztnvjfqwrcgsmlb", part: 2)).to eq(19)
      expect(runner.execute!("bvwbjplbgvbhsrlpgdmjqwftvncz", part: 2)).to eq(23)
      expect(runner.execute!("nppdvjthqldpwncqszvftbrmjlhg", part: 2)).to eq(23)
      expect(runner.execute!("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", part: 2)).to eq(29)
      expect(runner.execute!("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", part: 2)).to eq(26)
    end
  end
end
