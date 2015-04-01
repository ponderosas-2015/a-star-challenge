class Node
  attr_reader :next
  attr_accessor :element, :prev

  def initialize(element)
    @element = element
    @next = nil
    @prev = nil
  end

  def insert_after(other_node)
    return nil if other_node.nil?
    other_node.prev = self
    @next = other_node
  end

  def remove_after
    @next.prev = nil
    removed_node, @next = @next, nil
    removed_node
  end
end
