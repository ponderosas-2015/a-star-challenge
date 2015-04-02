require_relative 'priority_queue'

describe PriorityQueue do
  let(:element) { "hello" }
  let(:element2) { "world" }
  let(:priority_queue) { PriorityQueue.new }

  describe '#new()' do
    it 'Instantiates a new PriorityQueue' do
      expect(PriorityQueue.new).to be_an_instance_of PriorityQueue
    end
  end

  describe '#add(element, priority)' do
    it 'Add a new element to the priority_queue with a priority that is an integer value' do
      priority_queue.add(element, 1)
      expect(priority_queue.pull).to eq element
    end
    it 'Should not add an duplicate element to the priority_queue, but should update its priority' do
      priority_queue.add(element, 1)
      priority_queue.add(element, 1)
      priority_queue.pull
      expect(priority_queue.empty?).to be true
    end
  end

  describe '#pull' do
    it 'Remove the element with the highest priority from the priority_queue' do
      priority_queue.add(element, 1)
      priority_queue.add(element2, 2)
      expect(priority_queue.pull).to eq element2
    end
  end

  describe '#empty?' do
    it 'Answer whether or not the priority_queue is empty' do
      expect(priority_queue.empty?).to be true
      priority_queue.add(element, 1)
      expect(priority_queue.empty?).to be false
    end
  end

end
