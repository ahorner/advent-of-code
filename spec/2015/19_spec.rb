require "spec_helper"

RSpec.describe "Day 19: Medicine for Rudolph" do
  let(:runner) { Runner.new("2015/19") }
  let(:calibration_molecule) { "HOH" }
  let(:input) do
    <<~TXT
      H => HO
      H => OH
      O => HH
      e => H
      e => O

      #{calibration_molecule}
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the number of distinct molecules" do
      expect(solution).to eq(4)
    end

    describe "for Santa's favorite molecule" do
      let(:calibration_molecule) { "HOHOHO" }

      it "finds the number of distinct molecules" do
        expect(solution).to eq(7)
      end
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the number of steps to produce the target" do
      expect(solution).to eq(3)
    end

    describe "for Santa's favorite molecule" do
      let(:calibration_molecule) { "HOHOHO" }

      it "finds the number of steps to produce the target" do
        expect(solution).to eq(6)
      end
    end
  end
end
