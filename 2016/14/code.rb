require "digest"

class ScratchPad
  TRIPLE_MATCHER = /(\w)\1\1/.freeze

  def initialize(salt, stretch = 0)
    @salt = salt
    @stretch = stretch
    @generated = {}
  end

  def index(count)
    indices(count).last
  end

  def indices(count)
    i = 0
    found = []

    begin
      found << i if valid?(i)
      i += 1
    end while found.length < count

    found
  end

  def valid?(value)
    matches = generate(value).match(TRIPLE_MATCHER)
    return false unless matches

    matcher = Regexp.new((matches[1]).to_s * 5)
    (1..1000).any? { |i| generate(value + i) =~ matcher }
  end

  private

  def generate(value)
    @generated[value] ||= begin
      digest = Digest::MD5.hexdigest("#{@salt}#{value}")
      @stretch.times { digest = Digest::MD5.hexdigest(digest) }
      digest
    end
  end
end

SALT = INPUT.chomp

puts "The index of the 64th scratch pad value is:", ScratchPad.new(SALT).index(64), nil
puts "The index of the 64th scratch pad value (with stretching) is:", ScratchPad.new(SALT, 2016).index(64)
