require "spec_helper"

describe "Day 11: Corporate Policy" do
  let(:runner) { Runner.new("2015/11") }

  describe "Part One" do
    it "finds the next password by the rules" do
      expect(runner.execute!("abcdefgh", part: 1)).to eq("abcdffaa")
      expect(runner.execute!("ghijklmn", part: 1)).to eq("ghjaabcc")
    end
  end
end
