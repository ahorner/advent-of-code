require "spec_helper"

describe "Day 12: JSAbacusFramework.io" do
  let(:runner) { Runner.new("2015/12") }

  describe "Part One" do
    it "sums all numbers in the document" do
      expect(runner.execute!("[1,2,3]", part: 1)).to eq(6)
      expect(runner.execute!('{"a":2,"b":4}', part: 1)).to eq(6)
      expect(runner.execute!("[[[3]]]", part: 1)).to eq(3)
      expect(runner.execute!('{"a":{"b":4},"c":-1}', part: 1)).to eq(3)
      expect(runner.execute!('{"a":[-1,1]}', part: 1)).to eq(0)
      expect(runner.execute!('[-1,{"a":1}]', part: 1)).to eq(0)
      expect(runner.execute!("[]", part: 1)).to eq(0)
      expect(runner.execute!("{}", part: 1)).to eq(0)
    end
  end

  describe "Part Two" do
    it "ignores values in red" do
      expect(runner.execute!("[1,2,3]", part: 2)).to eq(6)
      expect(runner.execute!('[1,{"c":"red","b":2},3]', part: 2)).to eq(4)
      expect(runner.execute!('{"d":"red","e":[1,2,3,4],"f":5}', part: 2)).to eq(0)
      expect(runner.execute!('[1,"red",5]', part: 2)).to eq(6)
    end
  end
end
