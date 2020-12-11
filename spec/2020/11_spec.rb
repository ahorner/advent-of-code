require "spec_helper"

RSpec.describe "Day 11: Seating System" do
  let(:runner) { Runner.new("2020/11") }
  let(:input) do
    <<~TXT
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "counts occupied seats in the stable layout" do
      expect(solution).to eq(37)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "counts occupied seats in the new stable layout" do
      expect(solution).to eq(26)
    end
  end
end
