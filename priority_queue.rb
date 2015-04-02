class PriorityQueue

  def initialize
    @queue = []
  end

  def add(element, priority)
    @queue.delete_if { |pair| pair.first == element }
    @queue << [element, priority]
  end

  def pull
    @queue.sort_by! { |pair| pair.last }.pop[0]
  end

  def empty?
    @queue.empty?
  end
end
