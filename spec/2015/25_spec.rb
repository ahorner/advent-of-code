require "spec_helper"

RSpec.describe "Day 25: Let It Snow" do
  let(:runner) { Runner.new("2015/25") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the code for any given position" do
      expect(runner.execute!("row 1, column 1", part: 1)).to eq(20_151_125)
      expect(runner.execute!("row 2, column 1", part: 1)).to eq(31_916_031)
      expect(runner.execute!("row 1, column 2", part: 1)).to eq(18_749_137)
      expect(runner.execute!("row 3, column 1", part: 1)).to eq(16_080_970)
      expect(runner.execute!("row 2, column 2", part: 1)).to eq(21_629_792)
      expect(runner.execute!("row 1, column 3", part: 1)).to eq(17_289_845)
      expect(runner.execute!("row 4, column 1", part: 1)).to eq(24_592_653)
      expect(runner.execute!("row 3, column 2", part: 1)).to eq(8_057_251)
      expect(runner.execute!("row 2, column 3", part: 1)).to eq(16_929_656)
      expect(runner.execute!("row 1, column 4", part: 1)).to eq(30_943_339)
    end
  end
end
