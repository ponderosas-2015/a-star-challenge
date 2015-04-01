require_relative 'maze_solver'
require_relative 'maze'

describe MazeSolver do
  let(:text_file) {'map.1.txt'}
  let(:maze) {Maze.new(text_file)}
  let(:maze_solver) {MazeSolver.new(maze)}

	describe '::new' do
		it 'returns a new instance of MazeSolver' do
			expect(MazeSolver.new(maze)).to be_an_instance_of MazeSolver
		end
	end

  describe '#add_to_store(cell)' do
    it 'should add a cell to the store' do
      cell = [1,1]
      expect(maze_solver.instance_variable_get(:@store)).to receive(:push).with(cell)
      maze_solver.add_to_store(cell)
    end
  end

  describe '#get_next_in_store' do
    it 'should add a cell to the store' do
      cell = [1,1]
      maze_solver.add_to_store(cell)
      expect(maze_solver.get_next_in_store).to eq cell
    end
  end

  describe '#solved?(current)' do
    it 'should return true if the current cell is the end' do
      expect(maze_solver.solved?(maze.end)).to be true
    end
    it 'should return false if the current cell is the end' do
      expect(maze_solver.solved?(maze.start)).to be false
    end
  end

  describe '#find_edges(cell)' do
    it 'should return available cells when there is only one' do
      expect(maze_solver.find_edges(maze.start)).to eq [[1,0]]
    end
    it 'should return available cells when there are multiple' do
      expect(maze_solver.find_edges([3,0])).to include [2,0]
      expect(maze_solver.find_edges([3,0])).to include [4,0]
    end
  end

  describe '#possible_edges(cell)' do
    it 'should return four cells' do
      expect(maze_solver.possible_edges([0,0]).length).to eq 4
    end
    it 'should return one cell in each cardinal direction' do
      possible_edges = maze_solver.possible_edges([3,0])
      expect(possible_edges).to include [2,0]
      expect(possible_edges).to include [4,0]
      expect(possible_edges).to include [3,1]
      expect(possible_edges).to include [3,-1]
    end
  end
end
