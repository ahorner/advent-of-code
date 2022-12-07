require "spec_helper"

RSpec.describe "Day 7: No Space Left On Device" do
  let(:runner) { Runner.new("2022/07") }
  let(:input) do
    <<~TXT
      $ cd /
      $ ls
      dir a
      14848514 b.txt
      8504156 c.dat
      dir d
      $ cd a
      $ ls
      dir e
      29116 f
      2557 g
      62596 h.lst
      $ cd e
      $ ls
      584 i
      $ cd ..
      $ cd ..
      $ cd d
      $ ls
      4060174 j
      8033020 d.log
      5626152 d.ext
      7214296 k
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the total of all directories below a certain size" do
      expect(solution).to eq(95_437)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the smallest folder to remove" do
      expect(solution).to eq(24_933_642)
    end
  end
end
