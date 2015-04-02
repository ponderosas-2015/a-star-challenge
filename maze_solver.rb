require_relative 'maze'
require_relative 'astar'
require_relative 'pq'
require_relative 'bfs'
require_relative 'dfs'

class MazeSolver
  GRAPH_COST = 1
  SLEEP = 0.02

  def initialize(text_maze, strategy="bfs")
    @maze = Maze.new(text_maze)
    @strategy = select_strategy(strategy).new
    @steps = 0
  end

  def select_strategy(strategy)
    case strategy
    when "dfs"
      DFS
    when "pq"
      PQ
    when "astar"
      AStar
    else
      BFS
    end
  end

  def solve!
    path = @strategy.solve!(@maze) do |cell|
      @steps += 1
      print_maze
    end
    path.empty? ? print_unsolvable : construct_path(path)
  end

  def print_maze
    @maze.clear_screen
    puts @maze, "STEPS: #{@steps}"
    sleep(SLEEP)
  end

  def print_unsolvable
    @maze.reset!
    @maze.clear_screen
    puts @maze, "UNSOLVABLE"
  end

  def construct_path(came_from)
    @maze.reset!
    cell = @maze.end
    path = Stack.new
    until cell == @maze.start
      cell = came_from[cell]
      path.push(cell)
    end
    until path.empty?
      @maze.mark_cell(path.pop)
      print_maze
    end
  end
end
