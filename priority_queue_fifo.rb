class PriorityQueue

  def initialize
    @queue = [[]]
    @size = 0
  end

  def add(element, priority)
    remove(element)
    @size += 1
    resize(priority + 1) if @queue.length <= priority
    @queue[priority].unshift(element)
  end

  def find(element)
    @queue.each.with_index do |bucket, bucket_index|
      bucket.each.with_index do |el, element_index|
        return [bucket_index, element_index] if el == element
      end
    end
    return []
  end

  def remove(element)
    index = find(element)
    if !index.empty?
      @size -= 1
      @queue[index.first].delete_at(index.last)
    end
  end

  def pull
    @size -= 1
    highest_priority.pop
  end

  def highest_priority
    @queue.reverse.each do |cell|
      return cell if !cell.empty?
    end
  end

  def empty?
    @size.zero?
  end

  def resize(new_length)
    (new_length - @queue.length).times do
      @queue << []
    end
  end
end
