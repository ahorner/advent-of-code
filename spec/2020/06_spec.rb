require "spec_helper"

describe "Day 6: Custom Customs" do
  let(:runner) { Runner.new("2020/06") }

  describe "Part One" do
    let(:solution) { runner.execute!(input).first }

    describe "first example" do
      let(:input) do
        <<~TXT
          abcx
          abcy
          abcz
        TXT
      end

      it "calculates a proper sum" do
        expect(solution).to eq 6
      end
    end

    describe "second example" do
      let(:input) do
        <<~TXT
          abc

          a
          b
          c

          ab
          ac

          a
          a
          a
          a

          b
        TXT
      end

      it "calculates a proper sum" do
        expect(solution).to eq 11
      end
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input).last }
    let(:input) do
      <<~TXT
        abc

        a
        b
        c

        ab
        ac

        a
        a
        a
        a

        b
      TXT
    end

    it "calculates a proper sum" do
      expect(solution).to eq 6
    end
  end
end
