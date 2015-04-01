require_relative 'maze'
require_relative 'queue'
require_relative 'stack'

class MazeSolver
  STRATEGY = Stack

  def initialize(text_maze, strategy=STRATEGY)
    @maze = Maze.new(text_maze) # ["o#........", ".#####.##.", ".......##.", "######.#*.", ".......###"]
    @illustrative_maze = Maze.new(text_maze)
    @store = strategy.new
    @came_from = {}
  end

  def add_to_store(cell)
    @store.is_a?(Queue) ? @store.enqueue(cell) : @store.push(cell)
  end

  def get_next_in_store
    @store.is_a?(Queue) ? @store.dequeue : @store.pop
  end

  def solve!
    current = @maze.start
    add_to_store(current)
    @came_from[current] = nil
    until (solved?(current) || @store.empty?)
      current = get_next_in_store
      if @maze.available?(current) || @maze.start == current
        find_edges(current).each do |cell|
          add_to_store(cell)
          @came_from[cell] = current if !@came_from.has_key?(cell)
        end
        @maze.mark_cell(current)
        @maze.print_maze
      end
    end
    solved?(current) ? path_to(current) : print_unsolvable
  end

  def print_unsolvable
    @illustrative_maze.print_maze
    puts "UNSOLVABLE"
  end

  def path_to(cell)
    path = Stack.new
    until cell == @maze.start
      cell = @came_from[cell]
      path.push(cell)
    end
    until path.empty?
      @illustrative_maze.mark_cell(path.pop)
      @illustrative_maze.print_maze
    end
  end

  def solved?(current)
    current == @maze.end
  end

  def find_edges(cell)
    possible_edges(cell).select do |cell|
      @maze.within_maze_bounds?(cell) && @maze.available?(cell)
    end
  end

  def possible_edges(cell)
    row = cell.first
    col = cell.last
    [[row, col - 1], [row, col + 1], [row + 1, col], [row - 1, col]]
  end
end
