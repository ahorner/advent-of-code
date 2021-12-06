require "spec_helper"

RSpec.describe "Day 6: Lanternfish" do
  let(:runner) { Runner.new("2021/06") }
  let(:input) do
    <<~TXT
      3,4,3,1,2
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the number of lanternfish after 80 days" do
      expect(solution).to eq(5_934)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "finds the number of lanternfish after 256 days" do
      expect(solution).to eq(26_984_457_539)
    end
  end
end
