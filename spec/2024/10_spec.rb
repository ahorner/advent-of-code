require "spec_helper"

RSpec.describe "Day 10: Hoof It" do
  let(:runner) { Runner.new("2024/10") }

  describe "Part One" do
    it "calculates trailhead scores correctly" do
      expect(runner.execute!(<<~TXT, part: 1)).to eq(2)
        ...0...
        ...1...
        ...2...
        6543456
        7.....7
        8.....8
        9.....9
      TXT

      expect(runner.execute!(<<~TXT, part: 1)).to eq(4)
        ..90..9
        ...1.98
        ...2..7
        6543456
        765.987
        876....
        987....
      TXT

      expect(runner.execute!(<<~TXT, part: 1)).to eq(3)
        10..9..
        2...8..
        3...7..
        4567654
        ...8..3
        ...9..2
        .....01
      TXT

      expect(runner.execute!(<<~TXT, part: 1)).to eq(36)
        89010123
        78121874
        87430965
        96549874
        45678903
        32019012
        01329801
        10456732
      TXT
    end
  end

  describe "Part Two" do
    it "counts the number of unique trails" do
      expect(runner.execute!(<<~TXT, part: 2)).to eq(3)
        .....0.
        ..4321.
        ..5..2.
        ..6543.
        ..7..4.
        ..8765.
        ..9....
      TXT

      expect(runner.execute!(<<~TXT, part: 2)).to eq(13)
        ..90..9
        ...1.98
        ...2..7
        6543456
        765.987
        876....
        987....
      TXT

      expect(runner.execute!(<<~TXT, part: 2)).to eq(227)
        012345
        123456
        234567
        345678
        4.6789
        56789.
      TXT

      expect(runner.execute!(<<~TXT, part: 2)).to eq(81)
        89010123
        78121874
        87430965
        96549874
        45678903
        32019012
        01329801
        10456732
      TXT
    end
  end
end
