require "spec_helper"

describe "Day 25: Let It Snow" do
  let(:runner) { Runner.new("2015/25") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the code for any given position" do
      expect(runner.execute!("row 1, column 1", part: 1)).to eq(20151125)
      expect(runner.execute!("row 2, column 1", part: 1)).to eq(31916031)
      expect(runner.execute!("row 1, column 2", part: 1)).to eq(18749137)
      expect(runner.execute!("row 3, column 1", part: 1)).to eq(16080970)
      expect(runner.execute!("row 2, column 2", part: 1)).to eq(21629792)
      expect(runner.execute!("row 1, column 3", part: 1)).to eq(17289845)
      expect(runner.execute!("row 4, column 1", part: 1)).to eq(24592653)
      expect(runner.execute!("row 3, column 2", part: 1)).to eq(8057251)
      expect(runner.execute!("row 2, column 3", part: 1)).to eq(16929656)
      expect(runner.execute!("row 1, column 4", part: 1)).to eq(30943339)
    end
  end
end
