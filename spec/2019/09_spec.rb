require "spec_helper"

describe "Day 9: Sensor Boost" do
  let(:runner) { Runner.new("2019/09") }

  describe "Part One" do
    it "generates the expected outputs" do
      expect(runner.execute!("109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99", part: 1))
        .to eq([109, 1, 204, -1, 1_001, 100, 1, 100, 1_008, 100, 16, 101, 1_006, 101, 0, 99])
      expect(runner.execute!("1102,34915192,34915192,7,4,7,99,0", part: 1)[0].to_s.length).to eq(16)
      expect(runner.execute!("104,1125899906842624,99", part: 1)).to eq([1_125_899_906_842_624])
    end
  end
end
