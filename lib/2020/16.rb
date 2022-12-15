TICKET_MATCHER = /your ticket:\n(?<ticket>[0-9,]+)/
NEARBY_MATCHER = /nearby tickets:\n(?<tickets>[0-9,\n]+)/
FIELD_MATCHER = /^(?<field>.+): (?<ranges>.+)$/

FIELDS = INPUT.scan(FIELD_MATCHER).to_h.transform_values do |ranges|
  ranges.split(" or ").map do |range|
    starts, ends = range.split("-").map(&:to_i)
    starts..ends
  end
end.freeze

TICKET = INPUT.match(TICKET_MATCHER)[:ticket].split(",").map(&:to_i)
NEARBY_TICKETS = INPUT.match(NEARBY_MATCHER)[:tickets].split("\n").map do |ticket|
  ticket.split(",").map(&:to_i)
end.freeze

def invalid_scans(ticket)
  ticket.select do |value|
    FIELDS.none? { |_, ranges| ranges.any? { |range| range.include?(value) } }
  end
end

values = NEARBY_TICKETS.flat_map { |ticket| invalid_scans(ticket) }
solve!("The sum of invalid scanned values is:", values.sum)

def possibilities_for(ticket)
  ticket.map do |value|
    FIELDS.keys.select do |field|
      FIELDS[field].any? { |range| range.include?(value) }
    end
  end
end

def field_sequence(options)
  loop do
    break if options.all? { |possible| possible.length == 1 }

    found = options.select { |possible| possible.length == 1 }.flatten
    options = options.map { |possible| (possible.length == 1) ? possible : possible - found }
  end

  options.map(&:first)
end

valid_tickets = NEARBY_TICKETS.reject { |ticket| invalid_scans(ticket).any? }
options = valid_tickets.reduce(Array.new(FIELDS.count) { FIELDS.keys }) do |possibilities, ticket|
  fields = possibilities_for(ticket)
  possibilities.map.with_index { |possible, i| possible.intersection(fields[i]) }
end

FIELD_IDENTIFIER = "departure".freeze
values = field_sequence(options).map.with_index do |field, i|
  TICKET[i] if field.start_with?(FIELD_IDENTIFIER)
end.compact

solve!("The product of departure values is:", values.inject(:*))
