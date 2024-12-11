require "spec_helper"

RSpec.describe "Day 11: Plutonian Pebbles" do
  let(:runner) { Runner.new("2024/11") }

  describe "Part One" do
    it "calculates the number of stones after blinking" do
      expect(runner.execute!("0 1 10 99 999", part: 1, BLINKS: 1)).to eq(7)
      expect(runner.execute!("125 17", part: 1, BLINKS: 6)).to eq(22)
      expect(runner.execute!("125 17", part: 1)).to eq(55312)
    end
  end
end
