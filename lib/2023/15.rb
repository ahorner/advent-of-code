Step = Data.define(:step) do
  def verification
    hash_for(step)
  end

  def label
    step.scan(/\w+/).first
  end

  def box
    hash_for(label)
  end

  def insert?
    step.include?("=")
  end

  def focal_length
    return nil unless insert?

    step.scan(/\w+/).last.to_i
  end

  def hash_for(string)
    string.chars.reduce(0) do |value, c|
      value += c.ord
      (value * 17) % 256
    end
  end
end

SEQUENCE = INPUT.split(",").map { |step| Step.new(step) }.freeze

solve!("The verification code for initialization is:", SEQUENCE.sum(&:verification))

boxes = SEQUENCE.each_with_object(Hash.new { |h, k| h[k] = {} }) do |step, boxes|
  if step.insert?
    boxes[step.box][step.label] = step.focal_length
  else
    boxes[step.box].delete(step.label)
  end
end

power = boxes.sum do |box, lenses|
  lenses.each_with_index.sum { |(_, focal_length), index| (box + 1) * (index + 1) * focal_length }
end

solve!("The focusing power of the lenses after initialization is:", power)
