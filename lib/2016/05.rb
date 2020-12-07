require "digest"

def matching_digest(pattern, value = 0)
  loop do
    value += 1
    digest = Digest::MD5.hexdigest "#{INPUT}#{value}"
    break [digest, value] if digest.start_with?(pattern)
  end
end

value = 0
password = 8.times.map do
  digest, value = matching_digest("00000", value)
  digest[5]
end

solve!("The password is:", password.join)

value = 0
password = [nil] * 8
loop do
  digest, value = matching_digest("00000", value)
  next unless digest[5] =~ /\A[0-7]\z/

  password[digest[5].to_i] ||= digest[6]
  break unless password.any?(&:nil?)
end

solve!("The position-specified password is:", password.join)
