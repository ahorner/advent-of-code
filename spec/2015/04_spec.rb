require "spec_helper"

describe "Day 4: The Ideal Stocking Stuffer" do
  let(:runner) { Runner.new("2015/04") }

  describe "Part One" do
    it "finds an AdventCoin for the secret key" do
      expect(runner.execute!("abcdef", part: 1)).to eq(609043)
      expect(runner.execute!("pqrstuv", part: 1)).to eq(1048970)
    end
  end
end
