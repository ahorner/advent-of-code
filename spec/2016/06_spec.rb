require "spec_helper"

RSpec.describe "Day 6: Signals and Noise" do
  let(:runner) { Runner.new("2016/06") }
  let(:input) do
    <<~TXT
      eedadn
      drvtee
      eandsr
      raavrd
      atevrs
      tsrnev
      sdttsa
      rasrtv
      nssdts
      ntnada
      svetve
      tesnvt
      vntsnd
      vrdear
      dvrsen
      enarar
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "generates a code from the most common characters" do
      expect(solution).to eq("easter")
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "generates a code from the least common characters" do
      expect(solution).to eq("advent")
    end
  end
end
