require "digest"

def matching_digest(pattern)
  value = 0
  digest = nil

  loop do
    value += 1
    digest = Digest::MD5.new.hexdigest "#{INPUT}#{value}"
    break if digest.start_with?(pattern)
  end

  [digest, value]
end

solve!(*matching_digest("00000"))
solve!(*matching_digest("000000"))
