require "spec_helper"

RSpec.describe "Day 21: Step Counter" do
  let(:runner) { Runner.new("2023/21") }
  let(:input) do
    <<~TXT
      ...........
      .....###.#.
      .###.##..#.
      ..#.#...#..
      ....#.#....
      .##..S####.
      .##..#...#.
      .......##..
      .##.#.####.
      .##..##.##.
      ...........
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, STEPS: 6) }

    it "calculates the number of reachable spaces" do
      expect(solution).to eq(16)
    end
  end

  describe "Part Two" do
    # Using a modified test here to match the assumptions of the actual inputs.
    it "calculates the number of reachable spaces on an infinite grid" do
      expect(runner.execute!(<<~TXT, part: 2, STEPS: 0, INFINITE_STEPS: 17)).to eq(324)
        .......
        .......
        .......
        ...S...
        .......
        .......
        .......
      TXT

      expect(runner.execute!(<<~TXT, part: 2, STEPS: 0, INFINITE_STEPS: 17)).to eq(320)
        .......
        .......
        ....#..
        ...S...
        .......
        .......
        .......
      TXT

      expect(runner.execute!(<<~TXT, part: 2, STEPS: 0, INFINITE_STEPS: 17)).to eq(212)
        .......
        .##.##.
        .##.##.
        ...S...
        .##.##.
        .##.##.
        .......
      TXT
    end
  end
end
