require_relative 'maze'
require_relative 'queue'
require_relative 'stack'

class MazeSolver
  STRATEGY = Stack

  def initialize(maze, strategy=STRATEGY)
    @maze = maze # ["o#........", ".#####.##.", ".......##.", "######.#*.", ".......###"]
    @store = strategy.new
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
    until (solved?(current) || @store.empty?)
      current = get_next_in_store
      if @maze.available?(current) || @maze.start == current
        find_edges(current).each do |cell|
          add_to_store(cell)
        end
        @maze.mark_cell(current)
        @maze.print_maze
      end
    end
    solved?(current)
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
