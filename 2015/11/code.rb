class PasswordGenerator
  def initialize(seed)
    @current_password = seed
  end

  def next
    password = @current_password

    loop do
      password.succ!
      break if valid?(password)
    end

    @current_password = password
  end

  private

  def valid?(password)
    increasing_straight?(password) && two_pairs?(password) && !bad_chars?(password)
  end

  def increasing_straight?(string)
    # Omitting the following, as they contain i, o, or l (see `bad_chars?`):
    # ghi|hij|ijk|jkl|klm|lmn|mno|nop|opq
    string =~ /abc|bcd|cde|def|efg|fgh|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz/
  end

  def two_pairs?(string)
    string =~ /(.)\1.*(.)\2/
  end

  def bad_chars?(string)
    string =~ /[iol]/
  end
end

generator = PasswordGenerator.new(INPUT)

next_password = generator.next
puts "Next password should be:", next_password, nil

next_password = generator.next
puts "And then it should be:", next_password
