require "spec_helper"

RSpec.describe "Day 16: Packet Decoder" do
  let(:runner) { Runner.new("2021/16") }

  describe "Part One" do
    it "computes version sums for transmissions" do
      expect(runner.execute!("8A004A801A8002F478", part: 1)).to eq(16)
      expect(runner.execute!("620080001611562C8802118E34", part: 1)).to eq(12)
      expect(runner.execute!("C0015000016115A2E0802F182340", part: 1)).to eq(23)
      expect(runner.execute!("A0016C880162017C3686B18A3D4780", part: 1)).to eq(31)
    end
  end

  describe "Part Two" do
    it "computes values for transmissions" do
      expect(runner.execute!("C200B40A82", part: 2)).to eq(3)
      expect(runner.execute!("04005AC33890", part: 2)).to eq(54)
      expect(runner.execute!("880086C3E88112", part: 2)).to eq(7)
      expect(runner.execute!("CE00C43D881120", part: 2)).to eq(9)
      expect(runner.execute!("D8005AC2A8F0", part: 2)).to eq(1)
      expect(runner.execute!("F600BC2D8F", part: 2)).to eq(0)
      expect(runner.execute!("9C005AC2F8F0", part: 2)).to eq(0)
      expect(runner.execute!("9C0141080250320F1802104A08", part: 2)).to eq(1)
    end
  end
end
