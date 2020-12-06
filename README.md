# Advent of Code

A repository for the daily [Advent of Code](http://adventofcode.com/) challenges, with some utility scripts tossed in.

1. The new challenge is released at 12am EST!
2. `bin/start`
3. If there's an input file, dump the contents into `inputs/YYYY/DD.txt`, where `YYYY` is the challenge year, and `DD` is the zero-padded challenge date.
4. Write your solution code in `lib/YYYY/DD.rb`. Your input file will be available as a String constant named `INPUT`. Invoke `solve!` with your solution value(s).
5. Add specs for any given examples in the challenge description to `spec/YYYY/DD_spec.rb`, and use those specs to confirm whether or not your solution matches the described behavior.
6. `bin/run`


`bin/start` and `bin/run` can have an explicit date passed to them, if you need/want to run the code for a different date (e.g., `bin/run 2015/02`).
