require "spec_helper"

RSpec.describe "Day 4: The Ideal Stocking Stuffer" do
  let(:runner) { Runner.new("2015/04") }

  describe "Part One" do
    it "finds an AdventCoin for the secret key" do
      expect(runner.execute!("abcdef", part: 1)).to eq(609_043)
      expect(runner.execute!("pqrstuv", part: 1)).to eq(1_048_970)
    end
  end
end
