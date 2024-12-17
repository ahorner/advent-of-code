require "spec_helper"

RSpec.describe "Day 17: Chronospatial Computer" do
  let(:runner) { Runner.new("2024/17") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }
    let(:input) do
      <<~TXT
        Register A: 729
        Register B: 0
        Register C: 0

        Program: 0,1,5,4,3,0
      TXT
    end

    it "determines the output of the program" do
      expect(solution).to eq("4,6,3,5,6,3,5,2,1,0")
    end

    describe "given another program" do
      let(:input) do
        <<~TXT
          Register A: 2024
          Register B: 0
          Register C: 0

          0,1,5,4,3,0
        TXT
      end

      it "determines the output of the program" do
        expect(solution).to eq("4,2,5,6,7,7,7,7,3,1,0")
      end
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }
    let(:input) do
      <<~TXT
        Register A: 2024
        Register B: 0
        Register C: 0

        Program: 0,3,5,4,3,0
      TXT
    end

    it "finds the lowest initial value that produces a copy" do
      expect(solution).to eq(117440)
    end
  end
end
