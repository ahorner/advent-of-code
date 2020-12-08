require "spec_helper"

RSpec.describe "Day 1: Not Quite Lisp" do
  let(:runner) { Runner.new("2015/01") }

  describe "Part One" do
    it "finds the resulting floor" do
      expect(runner.execute!("(())", part: 1)).to eq(0)
      expect(runner.execute!("()()", part: 1)).to eq(0)
      expect(runner.execute!("(((", part: 1)).to eq(3)
      expect(runner.execute!("(()(()(", part: 1)).to eq(3)
      expect(runner.execute!("))(((((", part: 1)).to eq(3)
      expect(runner.execute!("())", part: 1)).to eq(-1)
      expect(runner.execute!(")))", part: 1)).to eq(-3)
      expect(runner.execute!(")())())", part: 1)).to eq(-3)
    end
  end

  describe "Part Two" do
    it "finds the first step that leads to the basement" do
      expect(runner.execute!(")", part: 2)).to eq(1)
      expect(runner.execute!("()())", part: 2)).to eq(5)
    end
  end
end
