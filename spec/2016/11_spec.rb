require "spec_helper"

RSpec.describe "Day 11: Radioisotope Thermoelectric Generators" do
  let(:runner) { Runner.new("2016/11") }
  let(:input) do
    <<~TXT
      The first floor contains a hydrogen-compatible microchip and a lithium-compatible microchip.
      The second floor contains a hydrogen generator.
      The third floor contains a lithium generator.
      The fourth floor contains nothing relevant.
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "finds the number of steps necessary to collect all objects" do
      expect(solution).to eq(11)
    end
  end
end
