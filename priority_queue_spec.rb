require_relative "priority_queue"

describe "PriorityQueue" do
  let(:priority_queue){PriorityQueue.new}
  describe "::new" do
    it "creates a new instance of PriorityQueue" do
    end
  end

  describe "#add(element, priority)" do
    context "the element already exists at a different priority" do
      it "Adds elements to the priority queue with a priority value of priority." do
        priority_queue.add("elem1", 2)
        priority_queue.add("elem2", 2)
        priority_queue.add("elem1", 4)
        expect(priority_queue.pull).to eq "elem2"
        expect(priority_queue.pull).to eq "elem1"
      end
    end
    context "the element is new" do
      it "Adds element to the priority queue." do
        priority_queue.add("elem1", 4)
        priority_queue.add("elem3", 2)
        expect(priority_queue.pull).to eq "elem3"
        expect(priority_queue.pull).to eq "elem1"
      end
    end
  end

  describe "#pull" do
    it "Removes and return the element with the highest priority from the queue." do
      priority_queue.add("elem1", 4)
      priority_queue.add("elem3", 2)
      expect(priority_queue.pull).to eq "elem3"
      expect(priority_queue.pull).to eq "elem1"
    end
  end

  describe "::empty?" do
    it "Returns true if the queue is empty" do
      expect(priority_queue.empty?).to be true
      priority_queue.add("elem1", 2)
      priority_queue.pull
      expect(priority_queue.empty?).to be true
    end
  end
end
