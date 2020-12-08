require "spec_helper"

RSpec.describe "Day 14: Reindeer Olympics" do
  let(:runner) { Runner.new("2015/14") }
  let(:input) do
    <<~TXT
      Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
      Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, TIME: 1000) }

    it "determines the distance travelled by the winner" do
      expect(solution).to eq(1120)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2, TIME: 1000) }

    it "determines the points gained by the winner" do
      expect(solution).to eq(689)
    end
  end
end
