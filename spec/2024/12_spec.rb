require "spec_helper"

RSpec.describe "Day 12: Garden Groups" do
  let(:runner) { Runner.new("2024/12") }

  describe "Part One" do
    it "computes the price of fencing for a garden plot" do
      expect(runner.execute!(<<~TXT, part: 1)).to eq(140)
        AAAA
        BBCD
        BBCC
        EEEC
      TXT

      expect(runner.execute!(<<~TXT, part: 1)).to eq(772)
        OOOOO
        OXOXO
        OOOOO
        OXOXO
        OOOOO
      TXT

      expect(runner.execute!(<<~TXT, part: 1)).to eq(1930)
        RRRRIICCFF
        RRRRIICCCF
        VVRRRCCFFF
        VVRCCCJFFF
        VVVVCJJCFE
        VVIVCCJJEE
        VVIIICJJEE
        MIIIIIJJEE
        MIIISIJEEE
        MMMISSJEEE
      TXT
    end
  end

  describe "Part Two" do
    it "computes the price of side-based fencing" do
      expect(runner.execute!(<<~TXT, part: 2)).to eq(80)
        AAAA
        BBCD
        BBCC
        EEEC
      TXT

      expect(runner.execute!(<<~TXT, part: 2)).to eq(436)
        OOOOO
        OXOXO
        OOOOO
        OXOXO
        OOOOO
      TXT

      expect(runner.execute!(<<~TXT, part: 2)).to eq(236)
        EEEEE
        EXXXX
        EEEEE
        EXXXX
        EEEEE
      TXT

      expect(runner.execute!(<<~TXT, part: 2)).to eq(368)
        AAAAAA
        AAABBA
        AAABBA
        ABBAAA
        ABBAAA
        AAAAAA
      TXT

      expect(runner.execute!(<<~TXT, part: 2)).to eq(1206)
        RRRRIICCFF
        RRRRIICCCF
        VVRRRCCFFF
        VVRCCCJFFF
        VVVVCJJCFE
        VVIVCCJJEE
        VVIIICJJEE
        MIIIIIJJEE
        MIIISIJEEE
        MMMISSJEEE
      TXT
    end
  end
end
