require "spec_helper"

RSpec.describe "Day 4: Security Through Obscurity" do
  let(:runner) { Runner.new("2016/04") }
  let(:input) do
    <<~TXT
      aaaaa-bbb-z-y-x-123[abxyz]
      a-b-c-d-e-f-g-h-987[abcde]
      not-a-real-room-404[oarel]
      totally-real-room-200[decoy]
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "sums the sector IDs of the real rooms" do
      expect(solution).to eq(1514)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2, TARGET_ROOM: "veryencryptedname") }
    let(:input) do
      <<~TXT
        qzmt-zixmtkozy-ivhz-343[zimth]
      TXT
    end

    it "finds the target room's sector ID" do
      expect(solution).to eq("343")
    end
  end
end
