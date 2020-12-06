require "digest"

def matching_digest(pattern)
  value = 0

  begin
    value += 1
    digest = Digest::MD5.new.hexdigest "#{INPUT}#{value}"
  end while !digest.start_with?(pattern)

  [digest, value]
end

puts(*matching_digest("00000"), nil)
puts(*matching_digest("000000"))
