ABBA_MATCHER = /(.)((?!\1).)\2\1/.freeze

def supports_tls?(supernet, hypernet)
  supernet.any? { |s| s =~ ABBA_MATCHER } && hypernet.none? { |s| s =~ ABBA_MATCHER }
end

def count_ips
  INPUT.split("\n").count do |line|
    components = line.split(/\[|\]/)
    supernet, hypernet = components.partition.with_index { |_, i| i.even? }
    yield supernet, hypernet
  end
end

count = count_ips { |supernet, hypernet| supports_tls?(supernet, hypernet) }
solve!("The number of IPs that support TLS:", count)

ABA_MATCHER = /\A.*([^,])((?!\1)[^,])\1.*~.*\2\1\2.*\z/.freeze

def supports_ssl?(supernet, hypernet)
  [supernet.join(","), hypernet.join(",")].join("~") =~ ABA_MATCHER
end

count = count_ips { |supernet, hypernet| supports_ssl?(supernet, hypernet) }
solve!("The number of IPs that support SSL", count)
