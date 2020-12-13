require "spec_helper"

RSpec.describe "Day 13: Shuttle Search" do
  let(:runner) { Runner.new("2020/13") }
  let(:input) do
    <<~TXT
      939
      7,13,x,x,59,x,31,19
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "multiplies the ID and wait time of the next bus" do
      expect(solution).to eq(295)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "computes the first timestamp with offset departures" do
      expect(solution).to eq(1_068_781)
    end

    it "computes timestamps for additional test cases" do
      {
        "17,x,13,19" => 3_417,
        "67,7,59,61" => 754_018,
        "67,x,7,59,61" => 779_210,
        "67,7,x,59,61" => 1_261_476,
        "1789,37,47,1889" => 1_202_161_486,
      }.each do |bus_ids, timestamp|
        expect(runner.execute!("0\n#{bus_ids}", part: 2)).to eq(timestamp)
      end
    end
  end
end
