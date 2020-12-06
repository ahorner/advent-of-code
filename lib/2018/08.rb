class Node
  def initialize(children, metadata)
    @children = children
    @metadata = metadata
  end

  def sum
    @children.sum(&:sum) + @metadata.sum
  end

  def value
    return @metadata.sum if @children.none?

    @metadata.sum { |i| @children[i - 1]&.value.to_i }
  end
end

def node_for(definition)
  child_count, metadata_count = definition.shift(2)

  children = child_count.times.map { node_for(definition) }
  metadata = definition.shift(metadata_count)

  Node.new(children, metadata)
end

root = node_for(INPUT.split.map(&:to_i))

solve!("The sum of all node metadata is:", root.sum)
solve!("The value of the root node is:", root.value)
