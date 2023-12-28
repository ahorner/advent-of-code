require "spec_helper"

RSpec.describe "Day 25: Snowverload" do
  let(:runner) { Runner.new("2023/25") }
  let(:input) do
    <<~TXT
      jqt: rhn xhk nvd
      rsh: frs pzl lsr
      xhk: hfx
      cmg: qnr nvd lhk bvb
      rhn: xhk bvb hfx
      bvb: xhk hfx
      pzl: lsr hfx nvd
      qnr: nvd
      ntq: jqt hfx bvb xhk
      nvd: lhk
      lsr: lhk
      rzs: qnr cmg lsr rsh
      frs: qnr lhk lsr
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the size of potential disconnected groups" do
      expect(solution).to eq(54)
    end
  end
end
