require "spec_helper"

describe "Day 13: Mine Cart Madness" do
  let(:runner) { Runner.new("2018/13") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }
    let(:input) do
      <<~'TXT'
        /->-\
        |   |  /----\
        | /-+--+-\  |
        | | |  | v  |
        \-+-/  \-+--/
          \------/
      TXT
    end

    it "finds the location of the first crash" do
      expect(solution).to eq "7,3"
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }
    let(:input) do
      <<~'TXT'
        />-<\
        |   |
        | /<+-\
        | | | v
        \>+</ |
          |   ^
          \<->/
      TXT
    end

    it "finds the location of the last remaining cart" do
      expect(solution).to eq "6,4"
    end
  end
end
