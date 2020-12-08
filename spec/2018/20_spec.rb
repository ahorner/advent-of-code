require "spec_helper"

describe "Day 20: A Regular Map" do
  let(:runner) { Runner.new("2018/20") }

  describe "Part One" do
    it "calculates the doors to the furthest room" do
      expect(runner.execute!("^WNE$", part: 1)).to eq(3)
      expect(runner.execute!("^ENWWW(NEEE|SSE(EE|N))$", part: 1)).to eq(10)
      expect(runner.execute!("^ENNWSWW(NEWS|)SSSEEN(WNSE|)EE(SWEN|)NNN$", part: 1)).to eq(18)
      expect(runner.execute!("^ESSWWN(E|NNENN(EESS(WNSE|)SSS|WWWSSSSE(SW|NNNE)))$", part: 1)).to eq(23)
      expect(runner.execute!("^WSSEESWWWNW(S|NENNEEEENN(ESSSSW(NWSW|SSEN)|WSWWN(E|WWS(E|SS))))$", part: 1)).to eq(31)
    end
  end
end
