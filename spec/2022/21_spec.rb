require "spec_helper"

RSpec.describe "Day 21: Monkey Math" do
  let(:runner) { Runner.new("2022/21") }
  let(:input) do
    <<~TXT
      root: pppw + sjmn
      dbpl: 5
      cczh: sllz + lgvd
      zczc: 2
      ptdq: humn - dvpt
      dvpt: 3
      lfqf: 4
      humn: 5
      ljgn: 2
      sjmn: drzm * dbpl
      sllz: 4
      pppw: cczh / lfqf
      lgvd: ljgn * ptdq
      drzm: hmdt - zczc
      hmdt: 32
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "determines what the root monkey yells" do
      expect(solution).to eq(152)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds a number to make the root monkey happy" do
      expect(solution).to eq(301)
    end
  end
end
