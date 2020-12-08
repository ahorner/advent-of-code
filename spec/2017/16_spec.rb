require "spec_helper"

RSpec.describe "Day 16: Permutation Promenade" do
  let(:runner) { Runner.new("2017/16") }
  let(:input) { "s1,x3/4,pe/b" }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, DANCERS: %w[a b c d e]) }

    it "determines the final order of the programs" do
      expect(solution).to eq("baedc")
    end
  end
end
