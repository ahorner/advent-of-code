require "spec_helper"

describe "Day 18: Many-Worlds Interpretation" do
  let(:runner) { Runner.new("2019/18") }

  describe "Part One" do
    let(:examples) do
      {
        8 => <<~TXT,
          #########
          #b.A.@.a#
          #########
        TXT
        81 => <<~TXT,
          ########################
          #@..............ac.GI.b#
          ###d#e#f################
          ###A#B#C################
          ###g#h#i################
          ########################
        TXT
        86 => <<~TXT,
          ########################
          #f.D.E.e.C.b.A.@.a.B.c.#
          ######################.#
          #d.....................#
          ########################
        TXT
        132 => <<~TXT,
          ########################
          #...............b.C.D.f#
          #.######################
          #.....@.a.B.c.d.A.e.F.g#
          ########################
        TXT
        136 => <<~TXT,
          #################
          #i.G..c...e..H.p#
          ########.########
          #j.A..b...f..D.o#
          ########@########
          #k.E..a...g..B.n#
          ########.########
          #l.F..d...h..C.m#
          #################
        TXT
      }
    end

    it "computes the minimum path that collects all keys" do
      examples.each do |steps, input|
        expect(runner.execute!(input, part: 1)).to eq(steps)
      end
    end
  end

  describe "Part Two" do
    let(:examples) do
      {
        8 => <<~TXT,
          #######
          #a.#Cd#
          ##...##
          ##.@.##
          ##...##
          #cB#Ab#
          #######
        TXT
        24 => <<~TXT,
          ###############
          #d.ABC.#.....a#
          ######...######
          ######.@.######
          ######...######
          #b.....#.....c#
          ###############
        TXT
        32 => <<~TXT,
          #############
          #DcBa.#.GhKl#
          #.###...#I###
          #e#d#.@.#j#k#
          ###C#...###J#
          #fEbA.#.FgHi#
          #############
        TXT
        72 => <<~TXT,
          #############
          #g#f.D#..h#l#
          #F###e#E###.#
          #dCba...BcIJ#
          #####.@.#####
          #nK.L...G...#
          #M###N#H###.#
          #o#m..#i#jk.#
          #############
        TXT
      }
    end

    it "computes the minimum steps to collect all keys" do
      examples.each do |steps, input|
        expect(runner.execute!(input, part: 2)).to eq(steps)
      end
    end
  end
end
