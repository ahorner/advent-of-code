require "spec_helper"

RSpec.describe "Day 21: Allergen Assessment1" do
  let(:runner) { Runner.new("2020/21") }
  let(:input) do
    <<~TXT
      mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
      trh fvjkl sbzzf mxmxvkd (contains dairy)
      sqjhc fvjkl (contains soy)
      sqjhc mxmxvkd sbzzf (contains fish)
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "counts the non-allergen ingredients" do
      expect(solution).to eq(5)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "produces a canonical dangerous ingredient list" do
      expect(solution).to eq("mxmxvkd,sqjhc,fvjkl")
    end
  end
end
