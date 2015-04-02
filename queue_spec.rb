require_relative 'queue'

describe Queue do
  let(:element) { "hello" }
  let(:element2) { "world" }
  let(:queue) { Queue.new }

  describe '#new()' do
    it 'Instantiates a new Queue' do
      expect(Queue.new).to be_an_instance_of Queue
    end
  end

  describe '#enqueue(element)' do
    it 'Add a new element to the queue' do
      queue.enqueue(element)
      expect(queue.peel).to eq element
    end
  end

  describe '#dequeue' do
    it 'Remove and return the first element in the queue' do
      queue.enqueue(element)
      queue.enqueue(element2)
      expect(queue.peel).to eq element
      expect(queue.dequeue).to eq element
      expect(queue.peel).to eq element2
    end
  end

  describe '#peel' do
    it 'Return (but do not remove) the first element in the queue' do
      queue.enqueue(element)
      expect(queue.peel).to eq element
      queue.enqueue(element2)
      expect(queue.peel).to eq element
    end
  end

  describe '#empty?' do
    it 'Answer whether or not the queue is empty' do
      expect(queue.empty?).to be true
      queue.enqueue(element)
      expect(queue.empty?).to be false
    end
  end

end
