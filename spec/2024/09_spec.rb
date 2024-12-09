require "spec_helper"

RSpec.describe "Day 9: Disk Fragmenter" do
  let(:runner) { Runner.new("2024/09") }
  let(:input) do
    <<~TXT
      2333133121414131402
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "computes the checksum of the compacted file system" do
      expect(solution).to eq(1928)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "computes the checksum after compacting with whole files" do
      expect(solution).to eq(2858)
    end
  end
end
