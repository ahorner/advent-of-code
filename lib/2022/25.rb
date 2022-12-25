VALUES = {
  "=" => -2,
  "-" => -1,
  "0" => 0,
  "1" => 1,
  "2" => 2
}

def parse(snafu)
  snafu.chars.reduce([]) do |places, c|
    places.map { |p| p * 5 } + [VALUES[c]]
  end.sum
end

def snafuize(value)
  carry = 0
  snafu = value.to_s(5).chars.reverse.map do |c|
    v = c.to_i + carry
    carry = v / 3
    VALUES.key(v - (carry * 5))
  end
  snafu << VALUES.key(carry) if carry > 0

  snafu.reverse.join
end

decimal = INPUT.split("\n").sum { |snafu| parse(snafu) }
solve!(
  "The SNAFU number you should supply is:",
  snafuize(decimal)
)
