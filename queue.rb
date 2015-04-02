require_relative 'linked_list'

class Queue

  def initialize
    @list = LinkedList.new
    @first = nil
  end

  def enqueue(element)
    node = Node.new(element)
    @first = node if empty?
    @list.insert_last(node)
  end

  def dequeue
    @first = @first.next
    @list.remove_first.element
  end

  def peel
    @first.element
  end

  def empty?
    @list.size.zero?
  end

end
