require "spec_helper"

RSpec.describe "Day 12: Subterranean Sustainability" do
  let(:runner) { Runner.new("2018/12") }
  let(:input) do
    <<~TXT
      initial state: #..#.#..##......###...###

      ...## => #
      ..#.. => #
      .#... => #
      .#.#. => #
      .#.## => #
      .##.. => #
      .#### => #
      #.#.# => #
      #.### => #
      ##.#. => #
      ##.## => #
      ###.. => #
      ###.# => #
      ####. => #
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "sums the planted pots" do
      expect(solution).to eq(325)
    end
  end
end
