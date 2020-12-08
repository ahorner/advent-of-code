require "spec_helper"

RSpec.describe "Day 15: Beverage Bandits" do
  let(:runner) { Runner.new("2018/15") }

  describe "Part One" do
    it "calculates the outcomes of various battles" do
      expect(runner.execute!(<<~TXT, part: 1)).to eq(27_730)
        #######
        #.G...#
        #...EG#
        #.#.#G#
        #..G#E#
        #.....#
        #######
      TXT
      expect(runner.execute!(<<~TXT, part: 1)).to eq(36_334)
        #######
        #G..#E#
        #E#E.E#
        #G.##.#
        #...#E#
        #...E.#
        #######
      TXT
      expect(runner.execute!(<<~TXT, part: 1)).to eq(39_514)
        #######
        #E..EG#
        #.#G.E#
        #E.##E#
        #G..#.#
        #..E#.#
        #######
      TXT
      expect(runner.execute!(<<~TXT, part: 1)).to eq(27_755)
        #######
        #E.G#.#
        #.#G..#
        #G.#.G#
        #G..#.#
        #...E.#
        #######
      TXT
      expect(runner.execute!(<<~TXT, part: 1)).to eq(28_944)
        #######
        #.E...#
        #.#..G#
        #.###.#
        #E#G#G#
        #...#G#
        #######
      TXT
      expect(runner.execute!(<<~TXT, part: 1)).to eq(18_740)
        #########
        #G......#
        #.E.#...#
        #..##..G#
        #...##..#
        #...#...#
        #.G...G.#
        #.....G.#
        #########
      TXT
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "calculates the outcomes of various epic battles" do
      expect(runner.execute!(<<~TXT, part: 2)).to eq(4988)
        #######
        #.G...#
        #...EG#
        #.#.#G#
        #..G#E#
        #.....#
        #######
      TXT
      expect(runner.execute!(<<~TXT, part: 2)).to eq(31_284)
        #######
        #E..EG#
        #.#G.E#
        #E.##E#
        #G..#.#
        #..E#.#
        #######
      TXT
      expect(runner.execute!(<<~TXT, part: 2)).to eq(3478)
        #######
        #E.G#.#
        #.#G..#
        #G.#.G#
        #G..#.#
        #...E.#
        #######
      TXT
      expect(runner.execute!(<<~TXT, part: 2)).to eq(6474)
        #######
        #.E...#
        #.#..G#
        #.###.#
        #E#G#G#
        #...#G#
        #######
      TXT
      expect(runner.execute!(<<~TXT, part: 2)).to eq(1140)
        #########
        #G......#
        #.E.#...#
        #..##..G#
        #...##..#
        #...#...#
        #.G...G.#
        #.....G.#
        #########
      TXT
    end
  end
end
