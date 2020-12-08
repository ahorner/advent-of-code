require "spec_helper"

describe "Day 16: Dragon Checksum" do
  let(:runner) { Runner.new("2016/16") }
  let(:input) { "10000" }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1, DISK_LENGTH: 20) }

    it "computes the correct checksum by disk length" do
      expect(solution).to eq("01100")
    end
  end
end
