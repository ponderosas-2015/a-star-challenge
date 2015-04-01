class PriorityQueue
  def initialize
    @container = []
  end

  def add(element, priority)
    @container.delete_if { |tuple| tuple[0] == element }
    @container.push([element, priority])
  end

  def pull
    @container.sort_by!{ |element| element[1] }
    element = @container.shift
    element[0]
  end

  def empty?
    @container.empty?
  end

end
