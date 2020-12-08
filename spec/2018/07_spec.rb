require "spec_helper"

describe "Day 7: The Sum of Its Parts" do
  let(:runner) { Runner.new("2018/07") }
  let(:input) do
    <<~TXT
      Step C must be finished before step A can begin.
      Step C must be finished before step F can begin.
      Step A must be finished before step B can begin.
      Step A must be finished before step D can begin.
      Step B must be finished before step E can begin.
      Step D must be finished before step E can begin.
      Step F must be finished before step E can begin.
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "sequences steps properly" do
      expect(solution).to eq("CABDFE")
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2, WORKER_COUNT: 2, TIME_OFFSET: 64) }

    it "finds the completion time for two workers" do
      expect(solution).to eq(15)
    end
  end
end
