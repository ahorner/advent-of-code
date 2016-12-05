require "digest"

def matching_digest(pattern, value = 0)
  begin
    value += 1
    digest = Digest::MD5.hexdigest "#{INPUT}#{value}"
  end while !digest.start_with?(pattern)

  return digest, value
end

value = 0
password = 8.times.map do
  digest, value = matching_digest("00000", value)
  digest[5]
end.join

puts "The password is:", password, nil

value = 0
password = [nil] * 8
begin
  digest, value = matching_digest("00000", value)
  next unless digest[5] =~ /\A[0-7]\z/

  password[digest[5].to_i] ||= digest[6]
end while password.any?(&:nil?)

puts "The position-specified password is:", password.join

