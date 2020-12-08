require "spec_helper"

RSpec.describe "Day 18: Settlers of The North Pole" do
  let(:runner) { Runner.new("2018/18") }
  let(:input) do
    <<~TXT
      .#.#...|#.
      .....#|##|
      .|..|...#.
      ..|#.....#
      #.#|||#|#|
      ...#.||...
      .|....|...
      ||...#|.#|
      |.||||..|.
      ...#.|..|.
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "computes the total resource value" do
      expect(solution).to eq(1147)
    end
  end
end
