require "spec_helper"

RSpec.describe "Day 25: Full of Hot Air" do
  let(:runner) { Runner.new("2022/25") }
  let(:input) do
    <<~TXT
      1=-0-2
      12111
      2=0=
      21
      2=01
      111
      20012
      112
      1=-1=
      1-12
      12
      1=
      122
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "composes the appropriate SNAFU number" do
      expect(solution).to eq("2=-1=0")
    end
  end
end
