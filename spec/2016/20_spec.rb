require "spec_helper"

describe "Day 20: Firewall Rules" do
  let(:runner) { Runner.new("2016/20") }
  let(:input) do
    <<~TXT
      5-8
      0-2
      4-7
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, VALID_IPS: 0..9) }

    it "finds the minimum valid IP address in the range" do
      expect(solution).to eq(3)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2, VALID_IPS: 0..9) }

    it "finds the total number of valid IP addresses in the range" do
      expect(solution).to eq(2)
    end
  end
end
