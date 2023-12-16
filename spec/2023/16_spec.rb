require "spec_helper"

RSpec.describe "Day 16: The Floor Will Be Lava" do
  let(:runner) { Runner.new("2023/16") }
  let(:input) do
    <<~'TXT'
      .|...\....
      |.-.\.....
      .....|-...
      ........|.
      ..........
      .........\
      ..../.\\..
      .-.-/..|..
      .|....-|.\
      ..//.|....
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the number of tiles that are energized by the beam" do
      expect(solution).to eq(46)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the most energy produced by any configuration" do
      expect(solution).to eq(51)
    end
  end
end
