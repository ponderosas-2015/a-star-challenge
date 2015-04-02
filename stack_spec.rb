require_relative 'stack'

describe Stack do
  let(:element) { "hello" }
  let(:element2) { "world" }
  let(:stack) { Stack.new }

  describe '#new()' do
    it 'Instantiates a new Stack' do
      expect(Stack.new).to be_an_instance_of Stack
    end
  end

  describe '#push(element)' do
    it 'Add a new element to the top of the stack' do
      stack.push(element)
      expect(stack.top).to eq element
    end
  end

  describe '#pop' do
    it 'Remove and return the top element of the stack' do
      stack.push(element)
      stack.push(element2)
      expect(stack.pop).to eq element2
      expect(stack.top).to eq element
    end
  end

  describe '#top' do
    it 'Return (but do not remove) the top element of the stack' do
      stack.push(element)
      expect(stack.top).to eq element
      stack.push(element)
      expect(stack.top).to eq element
    end
  end

  describe '#empty?' do
    it 'Answer whether or not the stack is empty' do
      expect(stack.empty?).to be true
      stack.push(element)
      expect(stack.empty?).to be false
    end
  end

end
