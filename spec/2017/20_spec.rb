require "spec_helper"

RSpec.describe "Day 20: Particle Swarm" do
  let(:runner) { Runner.new("2017/20") }

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }
    let(:input) do
      <<~TXT
        p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>
        p=< 4,0,0>, v=< 0,0,0>, a=<-2,0,0>
      TXT
    end

    it "determines which particle will stay closest" do
      expect(solution).to eq(0)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }
    let(:input) do
      <<~TXT
        p=<-6,0,0>, v=< 3,0,0>, a=< 0,0,0>
        p=<-4,0,0>, v=< 2,0,0>, a=< 0,0,0>
        p=<-2,0,0>, v=< 1,0,0>, a=< 0,0,0>
        p=< 3,0,0>, v=<-1,0,0>, a=< 0,0,0>
      TXT
    end

    it "determines the number of particles remaining after all collisions" do
      expect(solution).to eq(1)
    end
  end
end
