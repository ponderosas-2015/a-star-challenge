require_relative 'maze'

describe Maze do
  let(:text_file) {'map.1.txt'}
  let(:maze) {Maze.new(text_file)}

	describe '::new(text_file)' do
		it 'returns a new instance of MazeSolver' do
			expect(Maze.new(text_file)).to be_an_instance_of Maze
		end
	end

  describe 'read(text_file)' do
    it 'reads a text file into an Array' do
      expect(maze.send(:read,text_file)).to be_an_instance_of Array
    end
  end

  describe 'find(char)' do
    it 'finds the start index' do
      expect(maze.find('o')).to eq [0,0]
    end
    it 'finds the end index' do
      expect(maze.find('*')).to eq [3,8]
    end
  end

  describe 'mark_cell(cell)' do
    it 'marks an unvisited cell as visited' do
      unvisited = maze.find(".")
      maze.mark_cell(unvisited)
      maze_var = maze.instance_variable_get(:@maze)
      expect(maze_var[unvisited.first][unvisited.last]).to eq "X"
    end
    it 'will not mark an end cell as visited' do
      end_cell = maze.end
      maze.mark_cell(end_cell)
      maze_var = maze.instance_variable_get(:@maze)
      expect(maze_var[end_cell.first][end_cell.last]).to eq "*"
    end
  end

  describe 'available?(cell)' do
    it 'returns true for an available cell' do
      expect(maze.available?([1,0])).to be true
    end
    it 'returns false for an unavailable cell' do
      expect(maze.available?([1,1])).to be false
    end
  end
end
