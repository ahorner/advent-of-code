require "spec_helper"

RSpec.describe "Day 10: Pipe Maze" do
  let(:runner) { Runner.new("2023/10") }
  let(:input) do
    <<~TXT
      ..F7.
      .FJ|.
      SJ.L7
      |F--J
      LJ...
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the steps to the furthest pipe from the start" do
      expect(solution).to eq(8)
    end
  end

  describe "Part Two" do
    it "finds the number of tiles enclosed by the loop" do
      expect(runner.execute!(<<~TXT, part: 2)).to eq(4)
        ...........
        .S-------7.
        .|F-----7|.
        .||.....||.
        .||.....||.
        .|L-7.F-J|.
        .|..|.|..|.
        .L--J.L--J.
        ...........
      TXT

      expect(runner.execute!(<<~TXT, part: 2)).to eq(8)
        .F----7F7F7F7F-7....
        .|F--7||||||||FJ....
        .||.FJ||||||||L7....
        FJL7L7LJLJ||LJ.L-7..
        L--J.L7...LJS7F-7L7.
        ....F-J..F7FJ|L7L7L7
        ....L7.F7||L7|.L7L7|
        .....|FJLJ|FJ|F7|.LJ
        ....FJL-7.||.||||...
        ....L---J.LJ.LJLJ...
      TXT

      expect(runner.execute!(<<~TXT, part: 2)).to eq(10)
        FF7FSF7F7F7F7F7F---7
        L|LJ||||||||||||F--J
        FL-7LJLJ||||||LJL-77
        F--JF--7||LJLJ7F7FJ-
        L---JF-JLJ.||-FJLJJ7
        |F|F-JF---7F7-L7L|7|
        |FFJF7L7F-JF7|JL---7
        7-L-JL7||F7|L7F-7F7|
        L.L7LFJ|||||FJL7||LJ
        L7JLJL-JLJLJL--JLJ.L
      TXT
    end
  end
end
