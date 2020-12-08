require "spec_helper"

RSpec.describe "Day 10: Balance Bots" do
  let(:runner) { Runner.new("2016/10") }
  let(:input) do
    <<~TXT
      value 5 goes to bot 2
      bot 2 gives low to bot 1 and high to bot 0
      value 3 goes to bot 1
      bot 1 gives low to output 1 and high to bot 0
      bot 0 gives low to output 2 and high to output 0
      value 2 goes to bot 2
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, TARGET_VALUES: [2, 5]) }

    it "finds the bot responsible for comparing the target values" do
      expect(solution).to eq("bot 2")
    end
  end
end
