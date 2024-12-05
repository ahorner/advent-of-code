prereqs, updates = INPUT.split("\n\n")

PREREQS = prereqs.split("\n").each_with_object(Hash.new { |h, k| h[k] = [] }) do |line, reqs|
  a, b = line.split("|").map(&:to_i)
  reqs[b] << a
end
UPDATES = updates.split("\n").map { |line| line.split(",").map(&:to_i) }

def valid_page?(page, index, update, prereqs, processed)
  prereqs[page].empty? || prereqs[page].all? { |r| !update.include?(r) || processed[r] && processed[r] < index }
end

def valid?(update, prereqs)
  processed = {}

  update.each_with_index.all? do |page, i|
    processed[page] = i
    valid_page?(page, i, update, prereqs, processed)
  end
end

def score(updates)
  updates.sum { |update| update[update.length / 2] }
end

valid, invalid = UPDATES.partition { |update| valid?(update, PREREQS) }
solve!("The sum of middle page numbers for valid updates is:", score(valid))

def fix(update, prereqs)
  processed = {}
  fixed = []
  current = 0
  remaining = update

  loop do
    break fixed if remaining.empty?

    next_page = remaining.detect do |page|
      valid_page?(page, current, remaining, prereqs, processed)
    end

    fixed << next_page
    processed[next_page] = current
    current += 1
    remaining -= [next_page]
  end
end

fixed = invalid.map { |update| fix(update, PREREQS) }
solve!("The sum of middle page numbers for corrected updates is:", score(fixed))
