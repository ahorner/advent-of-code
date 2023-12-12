require "spec_helper"

RSpec.describe "Day 12: Hot Springs" do
  let(:runner) { Runner.new("2023/12") }
  let(:input) do
    <<~TXT
      ???.### 1,1,3
      .??..??...?##. 1,1,3
      ?#?#?#?#?#?#?#? 1,3,1,6
      ????.#...#... 4,1,1
      ????.######..#####. 1,6,5
      ?###???????? 3,2,1
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "sums the total possible arrangements" do
      expect(solution).to eq(21)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "sums the total possible arrangements of unfolded springs" do
      expect(solution).to eq(525152)
    end
  end
end
