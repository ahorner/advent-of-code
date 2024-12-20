require "spec_helper"

RSpec.describe "Day 20: Race Condition" do
  let(:runner) { Runner.new("2024/20") }
  let(:input) do
    <<~TXT
      ###############
      #...#...#.....#
      #.#.#.#.#.###.#
      #S#...#.#.#...#
      #######.#.#.###
      #######.#.#...#
      #######.#.###.#
      ###..E#...#...#
      ###.#######.###
      #...###...#...#
      #.#####.#.###.#
      #.#...#.#.#...#
      #.#.#.#.#.#.###
      #...#...#...###
      ###############
    TXT
  end

  describe "Part One" do
    it "finds the number of shortcuts that save N time" do
      expect(runner.execute!(input, part: 1, SAVINGS: 2)).to eq(44)
      expect(runner.execute!(input, part: 1, SAVINGS: 4)).to eq(30)
      expect(runner.execute!(input, part: 1, SAVINGS: 6)).to eq(16)
      expect(runner.execute!(input, part: 1, SAVINGS: 8)).to eq(14)
      expect(runner.execute!(input, part: 1, SAVINGS: 10)).to eq(10)
      expect(runner.execute!(input, part: 1, SAVINGS: 12)).to eq(8)
      expect(runner.execute!(input, part: 1, SAVINGS: 20)).to eq(5)
      expect(runner.execute!(input, part: 1, SAVINGS: 36)).to eq(4)
      expect(runner.execute!(input, part: 1, SAVINGS: 38)).to eq(3)
      expect(runner.execute!(input, part: 1, SAVINGS: 40)).to eq(2)
      expect(runner.execute!(input, part: 1, SAVINGS: 64)).to eq(1)
    end
  end

  describe "Part Two" do
    it "finds the number of longer shortcuts that save N time" do
      expect(runner.execute!(input, part: 2, SAVINGS: 50)).to eq(285)
      expect(runner.execute!(input, part: 2, SAVINGS: 52)).to eq(253)
      expect(runner.execute!(input, part: 2, SAVINGS: 54)).to eq(222)
      expect(runner.execute!(input, part: 2, SAVINGS: 56)).to eq(193)
      expect(runner.execute!(input, part: 2, SAVINGS: 58)).to eq(154)
      expect(runner.execute!(input, part: 2, SAVINGS: 60)).to eq(129)
      expect(runner.execute!(input, part: 2, SAVINGS: 62)).to eq(106)
      expect(runner.execute!(input, part: 2, SAVINGS: 64)).to eq(86)
      expect(runner.execute!(input, part: 2, SAVINGS: 66)).to eq(67)
      expect(runner.execute!(input, part: 2, SAVINGS: 68)).to eq(55)
      expect(runner.execute!(input, part: 2, SAVINGS: 70)).to eq(41)
      expect(runner.execute!(input, part: 2, SAVINGS: 72)).to eq(29)
      expect(runner.execute!(input, part: 2, SAVINGS: 74)).to eq(7)
      expect(runner.execute!(input, part: 2, SAVINGS: 76)).to eq(3)
    end
  end
end
