require "spec_helper"

RSpec.describe "Day 7: Handy Haversacks" do
  let(:runner) { Runner.new("2020/07") }
  let(:input) do
    <<~TXT
      light red bags contain 1 bright white bag, 2 muted yellow bags.
      dark orange bags contain 3 bright white bags, 4 muted yellow bags.
      bright white bags contain 1 shiny gold bag.
      muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
      shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
      dark olive bags contain 3 faded blue bags, 4 dotted black bags.
      vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
      faded blue bags contain no other bags.
      dotted black bags contain no other bags.
    TXT
  end

  describe "Part One" do
    let(:solution) { runner.execute!(input, part: 1) }

    it "determines the correct number of outermost bags" do
      expect(solution).to eq(4)
    end
  end

  describe "Part Two" do
    let(:solution) { runner.execute!(input, part: 2) }

    it "determines how many bags your bag contains" do
      expect(solution).to eq(32)
    end

    describe "for a different list of bags" do
      let(:input) do
        <<~TXT
          shiny gold bags contain 2 dark red bags.
          dark red bags contain 2 dark orange bags.
          dark orange bags contain 2 dark yellow bags.
          dark yellow bags contain 2 dark green bags.
          dark green bags contain 2 dark blue bags.
          dark blue bags contain 2 dark violet bags.
          dark violet bags contain no other bags.
        TXT
      end

      it "determines how many bags your bag contains" do
        expect(solution).to eq(126)
      end
    end
  end
end
