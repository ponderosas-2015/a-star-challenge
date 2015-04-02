require_relative 'linked_list'

class Stack

  def initialize
    @list = LinkedList.new
    @top = nil
  end

  def push(element)
    @top = Node.new(element)
    @list.insert_first(@top)
    self
  end

  def pop
    @top = @top.next
    @list.remove_first.element
  end

  def top
    @top.element
  end

  def empty?
    @list.size.zero?
  end
end
