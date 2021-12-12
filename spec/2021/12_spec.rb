require "spec_helper"

RSpec.describe "Day 12: Passage Pathing" do
  let(:runner) { Runner.new("2021/12") }
  let(:small_input) do
    <<~TXT
      start-A
      start-b
      A-c
      A-b
      b-d
      A-end
      b-end
    TXT
  end
  let(:medium_input) do
    <<~TXT
      dc-end
      HN-start
      start-kj
      dc-start
      dc-HN
      LN-dc
      HN-end
      kj-sa
      kj-HN
      kj-dc
    TXT
  end
  let(:large_input) do
    <<~TXT
      fs-end
      he-DX
      fs-he
      start-DX
      pj-DX
      end-zg
      zg-sl
      zg-pj
      pj-he
      RW-he
      fs-DX
      pj-RW
      zg-RW
      start-pj
      he-WI
      zg-he
      pj-fs
      start-RW
    TXT
  end

  describe "Part One" do
    it "finds the total number of distinct paths" do
      expect(runner.execute!(small_input, part: 1)).to eq(10)
      expect(runner.execute!(medium_input, part: 1)).to eq(19)
      expect(runner.execute!(large_input, part: 1)).to eq(226)
    end
  end

  describe "Part Two" do
    it "finds the number of distinct paths with revisitable small caves" do
      expect(runner.execute!(small_input, part: 2)).to eq(36)
      expect(runner.execute!(medium_input, part: 2)).to eq(103)
      expect(runner.execute!(large_input, part: 2)).to eq(3_509)
    end
  end
end
